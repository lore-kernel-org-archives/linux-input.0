From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Support for additional properties in touchscreen.h
Date: Tue, 14 Nov 2017 10:09:31 -0800
Message-ID: <20171114180931.lv4fga4lvrtvbnjt@dtor-ws>
References: <00f3838a-455a-574b-5a7a-c494cd39e36a@gmail.com>
 <CAKdAkRS5v8fcL7qzNQxCoos9TxxmTFSArXUcNDjTetVBFcwvAw@mail.gmail.com>
 <9b353e37-bba7-c367-bcb1-083e44f4a7b7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:49955 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754087AbdKNSJf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 13:09:35 -0500
Received: by mail-io0-f181.google.com with SMTP id x63so13148189ioe.6
        for <linux-input@vger.kernel.org>; Tue, 14 Nov 2017 10:09:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <9b353e37-bba7-c367-bcb1-083e44f4a7b7@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Hans de Goede <j.w.r.degoede@gmail.com>

On Tue, Nov 14, 2017 at 08:55:01AM +0100, Gregor Riepl wrote:
> > The fuzz (smoothing the output coordinates) is done in input core and
> > the touchscreen properties parsing code already handles
> > touchscreen-fuzz-x and touchscreen-fuzz-y parameters. The only thing
> > that is needed is to pass these parameters through DT or ACPI or
> > static properties, based on particular device.
> 
> Thanks for the clarification, Dmitry.
> 
> So do I understand correctly that it would suffice to add these parameters to
> a DMI match in drivers/platform/x86/silead_dmi.c ?
> 
> Something like:
> 
> static const struct property_entry my_imaginary_tablet_props[] = {
> 	PROPERTY_ENTRY_U32("touchscreen-size-x", 1920),
> 	PROPERTY_ENTRY_U32("touchscreen-size-y", 1080),
> 	PROPERTY_ENTRY_U32("touchscreen-fuzz-x", 10),
> 	PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 10),
> 	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-my-imaginary-tablet.fw"),
> 	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> 	{ }
> };

Yes, and you'd need to add a new entry to silead_ts_dmi_table.

Thanks.

-- 
Dmitry
