From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: [PATCH] OMAP: Add keypad driver
Date: Thu, 7 Jan 2016 12:37:51 +0300
Message-ID: <20160107093751.GD27186@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:43644 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbcAGJiD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2016 04:38:03 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Komal Shah <komal_shah802003@yahoo.com>
Cc: linux-input@vger.kernel.org

Hello file (standard input) matches,

The patch ad4e09b16ad3: "[PATCH] OMAP: Add keypad driver", leads to the
following static checker warning:

	drivers/input/keyboard/omap-keypad.c:158 omap_kp_tasklet()
	warn: 'keycodes[]' is never negative.

drivers/input/keyboard/omap-keypad.c
   129  static void omap_kp_tasklet(unsigned long data)
   130  {
   131          struct omap_kp *omap_kp_data = (struct omap_kp *) data;
   132          unsigned short *keycodes = omap_kp_data->input->keycode;
                ^^^^^^^^^^^^^^^^^^^^^^^^
   133          unsigned int row_shift = get_count_order(omap_kp_data->cols);
   134          unsigned char new_state[8], changed, key_down = 0;
   135          int col, row;
   136          int spurious = 0;
   137  
   138          /* check for any changes */
   139          omap_kp_scan_keypad(omap_kp_data, new_state);
   140  
   141          /* check for changes and print those */
   142          for (col = 0; col < omap_kp_data->cols; col++) {
   143                  changed = new_state[col] ^ keypad_state[col];
   144                  key_down |= new_state[col];
   145                  if (changed == 0)
   146                          continue;
   147  
   148                  for (row = 0; row < omap_kp_data->rows; row++) {
   149                          int key;
                                ^^^^^^^
   150                          if (!(changed & (1 << row)))
   151                                  continue;
   152  #ifdef NEW_BOARD_LEARNING_MODE
   153                          printk(KERN_INFO "omap-keypad: key %d-%d %s\n", col,
   154                                 row, (new_state[col] & (1 << row)) ?
   155                                 "pressed" : "released");
   156  #else
   157                          key = keycodes[MATRIX_SCAN_CODE(row, col, row_shift)];
   158                          if (key < 0) {
                                    ^^^^^^^
Never true.  Not sure what was intended.

   159                                  printk(KERN_WARNING
   160                                        "omap-keypad: Spurious key event %d-%d\n",
   161                                         col, row);
   162                                  /* We scan again after a couple of seconds */
   163                                  spurious = 1;
   164                                  continue;
   165                          }
   166  
   167                          if (!(kp_cur_group == (key & GROUP_MASK) ||
   168                                kp_cur_group == -1))
   169                                  continue;
   170  

regards,
dan carpenter
