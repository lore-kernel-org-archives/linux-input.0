From: Gregor Riepl <onitake@gmail.com>
Subject: Re: Support for additional properties in touchscreen.h
Date: Tue, 14 Nov 2017 08:55:01 +0100
Message-ID: <9b353e37-bba7-c367-bcb1-083e44f4a7b7@gmail.com>
References: <00f3838a-455a-574b-5a7a-c494cd39e36a@gmail.com>
 <CAKdAkRS5v8fcL7qzNQxCoos9TxxmTFSArXUcNDjTetVBFcwvAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54788 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbdKNHzF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Nov 2017 02:55:05 -0500
Received: by mail-wm0-f65.google.com with SMTP id r68so19976325wmr.3
        for <linux-input@vger.kernel.org>; Mon, 13 Nov 2017 23:55:04 -0800 (PST)
In-Reply-To: <CAKdAkRS5v8fcL7qzNQxCoos9TxxmTFSArXUcNDjTetVBFcwvAw@mail.gmail.com>
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Hans de Goede <j.w.r.degoede@gmail.com>

> The fuzz (smoothing the output coordinates) is done in input core and
> the touchscreen properties parsing code already handles
> touchscreen-fuzz-x and touchscreen-fuzz-y parameters. The only thing
> that is needed is to pass these parameters through DT or ACPI or
> static properties, based on particular device.

Thanks for the clarification, Dmitry.

So do I understand correctly that it would suffice to add these parameters to
a DMI match in drivers/platform/x86/silead_dmi.c ?

Something like:

static const struct property_entry my_imaginary_tablet_props[] = {
	PROPERTY_ENTRY_U32("touchscreen-size-x", 1920),
	PROPERTY_ENTRY_U32("touchscreen-size-y", 1080),
	PROPERTY_ENTRY_U32("touchscreen-fuzz-x", 10),
	PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 10),
	PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-my-imaginary-tablet.fw"),
	PROPERTY_ENTRY_U32("silead,max-fingers", 10),
	{ }
};
