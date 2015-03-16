From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: Fix sparse warning
Date: Mon, 16 Mar 2015 16:28:16 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1503161627430.25438@pobox.suse.cz>
References: <1424977484-31296-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48737 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965798AbbCPP2S (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 11:28:18 -0400
In-Reply-To: <1424977484-31296-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: fengguang.wu@intel.com, kbuild-all@01.org, linux-input@vger.kernel.org

On Thu, 26 Feb 2015, Srinivas Pandruvada wrote:

> Address issue reported by kbuild test robot <fengguang.wu@intel.com>
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/hid/hid-sensor-hub.c:223:39: sparse: incorrect type in argument 3 (different base types)
>    drivers/hid/hid-sensor-hub.c:223:39:    expected signed int [signed] [usertype] [explicitly-signed] <noident>
>    drivers/hid/hid-sensor-hub.c:223:39:    got restricted __le32 [usertype] <noident>
> >> drivers/hid/hid-sensor-hub.c:231:31: sparse: incorrect type in argument 3 (different base types)
>    drivers/hid/hid-sensor-hub.c:231:31:    expected signed int [signed] [usertype] [explicitly-signed] <noident>
>    drivers/hid/hid-sensor-hub.c:231:31:    got restricted __le32 [usertype] <noident>
> 
> vim +223 drivers/hid/hid-sensor-hub.c
> 
>    217          }
>    218
>    219          remaining_bytes = do_div(buffer_size, sizeof(__s32));
>    220          if (buffer_size) {
>    221                  for (i = 0; i < buffer_size; ++i) {
>    222                          hid_set_field(report->field[field_index], i,
>  > 223                                        cpu_to_le32(*buf32));
>    224                          ++buf32;
>    225                  }
>    226          }
>    227          if (remaining_bytes) {
>    228                  value = 0;
>    229                  memcpy(&value, (u8 *)buf32, remaining_bytes);
>    230                  hid_set_field(report->field[field_index], i,
>  > 231                                cpu_to_le32(value));
>    232          }
>    233          hid_hw_request(hsdev->hdev, report, HID_REQ_SET_REPORT);
>    234          hid_hw_wait(hsdev->hdev);
> 
> Since I can't change the type of hid_set_field argument 3, using __force __s32 to remove
> this warning.

Queued in for-4.1/sensor-hub

> ---

This '---' is wrong here, it would make git ignore your signoff. I have 
fixed that up.

> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

-- 
Jiri Kosina
SUSE Labs
