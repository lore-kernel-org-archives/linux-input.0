From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: i2c-hid: Allow ACPI systems to specify
 "post-power-on-delay-ms"
Date: Tue, 21 Nov 2017 13:30:27 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711211330090.11505@cbobk.fhfr.pm>
References: <20171002213215.32201-1-rajatja@google.com> <20171003181922.42827-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751684AbdKUMab (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Nov 2017 07:30:31 -0500
In-Reply-To: <20171003181922.42827-1-rajatja@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Arcari <darcari@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, HungNien Chen <hn.chen@weidahitech.com>, Hans de Goede <hdegoede@redhat.com>, Brian Norris <briannorris@chromium.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@google.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rajatxjain@gmail.com, Andy Shevchenko <andriy.shevchenko@linux.intel.com>

On Tue, 3 Oct 2017, Rajat Jain wrote:

> The property "post-power-on-delay-ms" allows a platform to specify
> the delay needed after power-on, but only via device trees currently.
> Use device_property_* instead of of_* reads to allow ACPI systems to
> also provide the same information. This is useful for Wacom hardware
> on ACPI systems.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v3: introduce i2c_hid_fwnode_probe() to parse common device_properties.
>     Also fixup the binding doc to indicate that regulator isn't a
>     requirement for "post-power-on-delay-ms"
> v2: Don't change any other existing logic, only read "post-power-on-delay-ms"
>     in i2c_hid_acpi_pdata() also.
> v1: Try to unify everything using device properties, convert i2c_hid_of_probe()
>     to i2c_hid_fwnode_probe() and call i2c_hid_acpi_pdata() if can't get
>     HID register address using device_property.

Queued now for 4.16 merge window.

-- 
Jiri Kosina
SUSE Labs

