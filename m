From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] usbhid: call report_fixup before comparing descriptors
Date: Tue, 18 Sep 2012 18:16:15 +0200
Message-ID: <20120918161615.GA1439@polaris.bitmath.org>
References: <50578272.1020902@kdau.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:37331 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab2IRQI1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Sep 2012 12:08:27 -0400
Content-Disposition: inline
In-Reply-To: <50578272.1020902@kdau.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Daughtridge <kevin@kdau.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Kevin,

> @@ -1436,6 +1436,10 @@ static int hid_post_reset(struct usb_int
>          kfree(rdesc);
>          return 1;
>      }
> +
> +    if (hid->driver && hid->driver->report_fixup)
> +        rdesc = hid->driver->report_fixup(hid, rdesc, &status);
> +
>      status = memcmp(rdesc, hid->rdesc, hid->rsize);

You can use dev_rdesc here instead.

Thanks,
Henrik
