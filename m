From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] OMAP: Add keypad driver
Date: Thu, 7 Jan 2016 10:54:11 -0800
Message-ID: <CAKdAkRSic46XAhuXO6fijBTWMaRJPqRNPx6MwTv=Pgoo6JL=hQ@mail.gmail.com>
References: <20160107093751.GD27186@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34731 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbcAGSyM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2016 13:54:12 -0500
Received: by mail-ob0-f174.google.com with SMTP id wp13so199193814obc.1
        for <linux-input@vger.kernel.org>; Thu, 07 Jan 2016 10:54:11 -0800 (PST)
In-Reply-To: <20160107093751.GD27186@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Tony Lindgren <tony@atomide.com>
Cc: Komal Shah <komal_shah802003@yahoo.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Aaro Koskinen <aaro.koskinen@nokia.com>

On Thu, Jan 7, 2016 at 1:37 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello file (standard input) matches,
>
> The patch ad4e09b16ad3: "[PATCH] OMAP: Add keypad driver", leads to the
> following static checker warning:
>
>         drivers/input/keyboard/omap-keypad.c:158 omap_kp_tasklet()
>         warn: 'keycodes[]' is never negative.

It looks like you are not resolving commits correctly, the original
submission did not have this issue.

>
> drivers/input/keyboard/omap-keypad.c
>    129  static void omap_kp_tasklet(unsigned long data)
>    130  {
>    131          struct omap_kp *omap_kp_data = (struct omap_kp *) data;
>    132          unsigned short *keycodes = omap_kp_data->input->keycode;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^
>    133          unsigned int row_shift = get_count_order(omap_kp_data->cols);
>    134          unsigned char new_state[8], changed, key_down = 0;
>    135          int col, row;
>    136          int spurious = 0;
>    137
>    138          /* check for any changes */
>    139          omap_kp_scan_keypad(omap_kp_data, new_state);
>    140
>    141          /* check for changes and print those */
>    142          for (col = 0; col < omap_kp_data->cols; col++) {
>    143                  changed = new_state[col] ^ keypad_state[col];
>    144                  key_down |= new_state[col];
>    145                  if (changed == 0)
>    146                          continue;
>    147
>    148                  for (row = 0; row < omap_kp_data->rows; row++) {
>    149                          int key;
>                                 ^^^^^^^
>    150                          if (!(changed & (1 << row)))
>    151                                  continue;
>    152  #ifdef NEW_BOARD_LEARNING_MODE
>    153                          printk(KERN_INFO "omap-keypad: key %d-%d %s\n", col,
>    154                                 row, (new_state[col] & (1 << row)) ?
>    155                                 "pressed" : "released");
>    156  #else
>    157                          key = keycodes[MATRIX_SCAN_CODE(row, col, row_shift)];
>    158                          if (key < 0) {
>                                     ^^^^^^^
> Never true.  Not sure what was intended.

It looks like this check was broken by
da1f026b532ce944d74461497dc6d8c16456466e (Keyboard: omap-keypad: use
matrix_keypad.h). Previously the driver would expect a list of known
keys and would scan it and return -1 if key was not found. Now we have
2 options:

1. Simply remove the check
2. Change the condition to "if (key == KEY_RESERVED)"

I do not really have preference. Tony?

Thanks.

-- 
Dmitry
