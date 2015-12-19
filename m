From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [PATCH] HID: sensor-hub: Add quirk for Lenovo Yoga 900 with ITE Chips
Date: Fri, 18 Dec 2015 22:31:22 -0800
Message-ID: <CAOhV88P35k37uP1=qhsThgrA4Y7iOn6fARps-N6DxaSpzKkztA@mail.gmail.com>
References: <1450463680-10400-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:35736 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbbLSGbX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2015 01:31:23 -0500
Received: by mail-yk0-f180.google.com with SMTP id v6so82490349ykc.2
        for <linux-input@vger.kernel.org>; Fri, 18 Dec 2015 22:31:23 -0800 (PST)
In-Reply-To: <1450463680-10400-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org

On Fri, Dec 18, 2015 at 10:34 AM, Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
> This needs same quirk as applied to other YOGA sensor hubs.
> Refer to
> 47eeca8a48 (" HID: sensor-hub: Add in quirk for Lenovo Yogas with ITE")
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Tested-by: Nishanth Aravamudan <nish.aravamudan@gmail.com>

Ok, maybe I spoke too soon! It did work once, at least. But since then
it seems to have stopped working again? That is, the *raw* files are
still working, but iio-sensor-proxy is again not seeing any updates
via the chardev(s). Any notion of what might be going on?

Note that dmesg does contain (it always has):

i2c_hid i2c-ITE8396:00: error in i2c_hid_init_report size:19 / ret_size:18

but I have no idea if that's relevant to the IIO sensors? I was told
in another thread that it shouldn't have any negative consequence.
-Nish
