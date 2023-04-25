from RPA.Desktop import Desktop
desktop = Desktop()


def navigate_all_positive_stocks():
    stock_elems = desktop.find_elements("alias:GreenStock")
    for stock_elem in stock_elems:
        desktop.click_with_offset(stock_elem, x=-150)
        elem_obj = desktop.find_element("alias:SearchButton")
        moved_obj = desktop.move_region(elem_obj, 330, 0)
        region_obj = desktop.resize_region(moved_obj, 0, 0, 700, 800)
        text = desktop.read_text(region_obj)
        print(text)


