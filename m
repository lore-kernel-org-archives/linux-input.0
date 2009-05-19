From: Rafi Rubin <rafi@seas.upenn.edu>
Subject: Re: [PATCH 1/3 ] hid: Multitouch support for the N-Trig touchscreen
Date: Tue, 19 May 2009 16:16:08 -0400
Message-ID: <4A131388.1030709@seas.upenn.edu>
References: <2DCAF4CF-1408-4C2E-9713-5BD901899953@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from LION.seas.upenn.edu ([158.130.12.194]:54860 "EHLO
	lion.seas.upenn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753705AbZESUQo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 May 2009 16:16:44 -0400
In-Reply-To: <2DCAF4CF-1408-4C2E-9713-5BD901899953@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, jkosina@suze.cz, Henrik Rydberg <rydberg@euromail.se>, Mohamed Ikbel Boulabiar <medikbel@lii-enac.fr>, Sebastien Hamdani <sebastien.hamdani@gmail.com>

I suggest adding a comment that these usages are tentative or at least not yet mentioned in the official docs:
http://www.usb.org/developers/hidpage#HID_Usage

Anyway, very cool that you figured out all those fields.  I haven't even seen any of those codes in the 50's.

Rafi

> +    {0, 0x47, "Confidence"},
> +    {0, 0x48, "Width"},
> +    {0, 0x49, "Height"},
> +    {0, 0x51, "ContactID"},
> +    {0, 0x52, "InputMode"},
> +    {0, 0x53, "DeviceIndex"},
> +    {0, 0x54, "ContactCount"},
> +    {0, 0x55, "ContactMaximumNumber"},

> +#define HID_DG_CONFIDENCE    0x000d0047
> +#define HID_DG_WIDTH        0x000d0048
> +#define HID_DG_HEIGHT        0x000d0049
> +#define HID_DG_CONTACTID    0x000d0051
> +#define HID_DG_INPUTMODE    0x000d0052
> +#define HID_DG_DEVICEINDEX    0x000d0053
> +#define HID_DG_CONTACTCOUNT    0x000d0054
> +#define HID_DG_CONTACTMAX    0x000d0055

