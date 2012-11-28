From: kbuild test robot <fengguang.wu@intel.com>
Subject: [input:synaptics-rmi4 6/11] drivers/input/rmi4/rmi_f11.c:1681:11: warning: 'w_min' may be used uninitialized in this function
Date: Wed, 28 Nov 2012 14:22:00 +0800
Message-ID: <50b5ad88.VwkGslHM7n//Codg%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16010 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575Ab2K1GXK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Nov 2012 01:23:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git synaptics-rmi4
head:   0af25383d395fb5ece54b79d12d06138bf8b9836
commit: 29991cc881df0747b1c09284d488b4b846adc177 [6/11] Input: input/rmi4 - F11 - 2D touch interface
config: make ARCH=x86_64 allmodconfig

Note: the input/synaptics-rmi4 HEAD 0af2538 builds fine.
      It only hurts bisectibility.

All error/warnings:

drivers/built-in.o: In function `rmi_set_page':
rmi_i2c.c:(.text+0x12935a): undefined reference to `i2c_master_send'
drivers/built-in.o: In function `rmi_i2c_read_block':
rmi_i2c.c:(.text+0x1295dc): undefined reference to `i2c_master_send'
rmi_i2c.c:(.text+0x12961e): undefined reference to `i2c_master_recv'
drivers/built-in.o: In function `rmi_i2c_write_block':
rmi_i2c.c:(.text+0x12988e): undefined reference to `i2c_master_send'
drivers/built-in.o: In function `rmi_i2c_init':
rmi_i2c.c:(.init.text+0xce33): undefined reference to `i2c_register_driver'
drivers/built-in.o: In function `rmi_i2c_exit':
rmi_i2c.c:(.exit.text+0x7a4): undefined reference to `i2c_del_driver'
--
drivers/input/rmi4/rmi_f11.c: In function 'rmi_f11_attention':
drivers/input/rmi4/rmi_f11.c:1681:11: warning: 'w_min' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/input/rmi4/rmi_f11.c:1625:23: note: 'w_min' was declared here
drivers/input/rmi4/rmi_f11.c:1680:11: warning: 'w_max' may be used uninitialized in this function [-Wmaybe-uninitialized]
drivers/input/rmi4/rmi_f11.c:1625:16: note: 'w_max' was declared here

vim +1681 +/w_min drivers/input/rmi4/rmi_f11.c

29991cc8 Christopher Heiny 2012-11-26  1619  				   struct f11_2d_sensor *sensor,
29991cc8 Christopher Heiny 2012-11-26  1620  				   u8 finger_state, u8 n_finger)
29991cc8 Christopher Heiny 2012-11-26  1621  {
29991cc8 Christopher Heiny 2012-11-26  1622  	struct f11_2d_data *data = &sensor->data;
29991cc8 Christopher Heiny 2012-11-26  1623  	struct rmi_f11_2d_axis_alignment *axis_align = &sensor->axis_align;
29991cc8 Christopher Heiny 2012-11-26  1624  	int x, y, z;
29991cc8 Christopher Heiny 2012-11-26 @1625  	int w_x, w_y, w_max, w_min, orient;
29991cc8 Christopher Heiny 2012-11-26  1626  	int temp;
29991cc8 Christopher Heiny 2012-11-26  1627  
29991cc8 Christopher Heiny 2012-11-26  1628  	if (finger_state) {
29991cc8 Christopher Heiny 2012-11-26  1629  		x = ((data->abs_pos[n_finger].x_msb << 4) |
29991cc8 Christopher Heiny 2012-11-26  1630  			data->abs_pos[n_finger].x_lsb);
29991cc8 Christopher Heiny 2012-11-26  1631  		y = ((data->abs_pos[n_finger].y_msb << 4) |
29991cc8 Christopher Heiny 2012-11-26  1632  			data->abs_pos[n_finger].y_lsb);
29991cc8 Christopher Heiny 2012-11-26  1633  		z = data->abs_pos[n_finger].z;
29991cc8 Christopher Heiny 2012-11-26  1634  		w_x = data->abs_pos[n_finger].w_x;
29991cc8 Christopher Heiny 2012-11-26  1635  		w_y = data->abs_pos[n_finger].w_y;
29991cc8 Christopher Heiny 2012-11-26  1636  		w_max = max(w_x, w_y);
29991cc8 Christopher Heiny 2012-11-26  1637  		w_min = min(w_x, w_y);
29991cc8 Christopher Heiny 2012-11-26  1638  
29991cc8 Christopher Heiny 2012-11-26  1639  		if (axis_align->swap_axes) {
29991cc8 Christopher Heiny 2012-11-26  1640  			temp = x;
29991cc8 Christopher Heiny 2012-11-26  1641  			x = y;
29991cc8 Christopher Heiny 2012-11-26  1642  			y = temp;
29991cc8 Christopher Heiny 2012-11-26  1643  			temp = w_x;
29991cc8 Christopher Heiny 2012-11-26  1644  			w_x = w_y;
29991cc8 Christopher Heiny 2012-11-26  1645  			w_y = temp;
29991cc8 Christopher Heiny 2012-11-26  1646  		}
29991cc8 Christopher Heiny 2012-11-26  1647  
29991cc8 Christopher Heiny 2012-11-26  1648  		orient = w_x > w_y ? 1 : 0;
29991cc8 Christopher Heiny 2012-11-26  1649  
29991cc8 Christopher Heiny 2012-11-26  1650  		if (axis_align->flip_x)
29991cc8 Christopher Heiny 2012-11-26  1651  			x = max(sensor->max_x - x, 0);
29991cc8 Christopher Heiny 2012-11-26  1652  
29991cc8 Christopher Heiny 2012-11-26  1653  		if (axis_align->flip_y)
29991cc8 Christopher Heiny 2012-11-26  1654  			y = max(sensor->max_y - y, 0);
29991cc8 Christopher Heiny 2012-11-26  1655  
29991cc8 Christopher Heiny 2012-11-26  1656  		/*
29991cc8 Christopher Heiny 2012-11-26  1657  		* here checking if X offset or y offset are specified is
29991cc8 Christopher Heiny 2012-11-26  1658  		*  redundant.  We just add the offsets or, clip the values
29991cc8 Christopher Heiny 2012-11-26  1659  		*
29991cc8 Christopher Heiny 2012-11-26  1660  		* note: offsets need to be done before clipping occurs,
29991cc8 Christopher Heiny 2012-11-26  1661  		* or we could get funny values that are outside
29991cc8 Christopher Heiny 2012-11-26  1662  		* clipping boundaries.
29991cc8 Christopher Heiny 2012-11-26  1663  		*/
29991cc8 Christopher Heiny 2012-11-26  1664  		x += axis_align->offset_X;
29991cc8 Christopher Heiny 2012-11-26  1665  		y += axis_align->offset_Y;
29991cc8 Christopher Heiny 2012-11-26  1666  		x =  max(axis_align->clip_X_low, x);
29991cc8 Christopher Heiny 2012-11-26  1667  		y =  max(axis_align->clip_Y_low, y);
29991cc8 Christopher Heiny 2012-11-26  1668  		if (axis_align->clip_X_high)
29991cc8 Christopher Heiny 2012-11-26  1669  			x = min(axis_align->clip_X_high, x);
29991cc8 Christopher Heiny 2012-11-26  1670  		if (axis_align->clip_Y_high)
29991cc8 Christopher Heiny 2012-11-26  1671  			y =  min(axis_align->clip_Y_high, y);
29991cc8 Christopher Heiny 2012-11-26  1672  
29991cc8 Christopher Heiny 2012-11-26  1673  	}
29991cc8 Christopher Heiny 2012-11-26  1674  
29991cc8 Christopher Heiny 2012-11-26  1675  	/* Some UIs ignore W of zero, so we fudge it to 1 for pens.  This
29991cc8 Christopher Heiny 2012-11-26  1676  	 * only appears to be an issue when reporting pens, not plain old
29991cc8 Christopher Heiny 2012-11-26  1677  	 * fingers. */
29991cc8 Christopher Heiny 2012-11-26  1678  	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
29991cc8 Christopher Heiny 2012-11-26  1679  			get_tool_type(sensor, finger_state) == MT_TOOL_PEN) {
29991cc8 Christopher Heiny 2012-11-26 @1680  		w_max = max(1, w_max);
29991cc8 Christopher Heiny 2012-11-26 @1681  		w_min = max(1, w_min);
29991cc8 Christopher Heiny 2012-11-26  1682  	}
29991cc8 Christopher Heiny 2012-11-26  1683  
29991cc8 Christopher Heiny 2012-11-26  1684  	if (sensor->type_a) {

---
0-DAY kernel build testing backend         Open Source Technology Center
Fengguang Wu, Yuanhan Liu                              Intel Corporation
