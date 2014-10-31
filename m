From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: HID: Introduce hidpp, a module to handle Logitech hid++ devices
Date: Fri, 31 Oct 2014 09:55:48 -0400
Message-ID: <20141031135548.GC24511@mail.corp.redhat.com>
References: <20141031091509.GB11252@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47475 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932326AbaJaNz4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2014 09:55:56 -0400
Content-Disposition: inline
In-Reply-To: <20141031091509.GB11252@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Dan,

On Oct 31 2014 or thereabouts, Dan Carpenter wrote:
> Hello Benjamin Tissoires,
> 
> The patch 2f31c5252910: "HID: Introduce hidpp, a module to handle
> Logitech hid++ devices" from Sep 30, 2014, leads to the following
> static checker warning:
> 
> 	drivers/hid/hid-logitech-hidpp.c:359 hidpp_root_get_protocol_version()
> 	warn: should this return really be negated?
> 
> drivers/hid/hid-logitech-hidpp.c
>    342  static int hidpp_root_get_protocol_version(struct hidpp_device *hidpp)
>    343  {
>    344          struct hidpp_report response;
>    345          int ret;
>    346  
>    347          ret = hidpp_send_fap_command_sync(hidpp,
>    348                          HIDPP_PAGE_ROOT_IDX,
>    349                          CMD_ROOT_GET_PROTOCOL_VERSION,
>    350                          NULL, 0, &response);
>    351  
>    352          if (ret == 1) {
>                     ^^^^^^^^
> What does the "1" mean?  Magic numbers are bad, yada yada yada.

Indeed. It should be HIDPP_ERROR_INVALID_SUBID.

> 
>    353                  hidpp->protocol_major = 1;
>    354                  hidpp->protocol_minor = 0;
>    355                  return 0;
>    356          }
>    357  
>    358          if (ret)
>    359                  return -ret;
>                         ^^^^^^^^^^^
> This is wrong.  The real problem is that hidpp_send_fap_command_sync()
> mixes normal and custom error codes.  The callers are inconsistent in
> how they deal with it.
> 

Yep :/

So, to sum up, positive errors are errors handled by the protocol.
Negative ones are the normal error codes.
I guess if the error is positive, we should drop an hid_err in the
syslog and convert it into -EPROTO.

>    360  
>    361          hidpp->protocol_major = response.fap.params[0];
>    362          hidpp->protocol_minor = response.fap.params[1];
>    363  
>    364          return ret;
>    365  }
> 
> See also:
> 
> drivers/hid/hid-logitech-hidpp.c:398 hidpp_devicenametype_get_count() warn: should this return really be negated?
> drivers/hid/hid-logitech-hidpp.c:417 hidpp_devicenametype_get_device_name() warn: should this return really be negated?
> drivers/hid/hid-logitech-hidpp.c:524 hidpp_touchpad_get_raw_info() warn: should this return really be negated?

Same will apply for these 3 others negated err.

Thanks for the reports!

Cheers,
Benjamin

