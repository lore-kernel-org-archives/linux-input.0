From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: [PATCH] HID: sensor-hub: Add quirk for Lenovo Yoga 900 with ITE Chips
Date: Sat, 19 Dec 2015 09:21:37 -0800
Message-ID: <CAOhV88NiqWR6VvuRakQKNUT-Vv87NnA52qEhz_1YS7xyKjkggA@mail.gmail.com>
References: <1450463680-10400-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<CAOhV88P35k37uP1=qhsThgrA4Y7iOn6fARps-N6DxaSpzKkztA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33266 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933209AbbLSRVi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2015 12:21:38 -0500
Received: by mail-yk0-f174.google.com with SMTP id 140so92326442ykp.0
        for <linux-input@vger.kernel.org>; Sat, 19 Dec 2015 09:21:38 -0800 (PST)
In-Reply-To: <CAOhV88P35k37uP1=qhsThgrA4Y7iOn6fARps-N6DxaSpzKkztA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org

On Fri, Dec 18, 2015 at 10:31 PM, Nish Aravamudan
<nish.aravamudan@gmail.com> wrote:
> On Fri, Dec 18, 2015 at 10:34 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>> This needs same quirk as applied to other YOGA sensor hubs.
>> Refer to
>> 47eeca8a48 (" HID: sensor-hub: Add in quirk for Lenovo Yogas with ITE")
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> Tested-by: Nishanth Aravamudan <nish.aravamudan@gmail.com>
>
> Ok, maybe I spoke too soon! It did work once, at least. But since then
> it seems to have stopped working again? That is, the *raw* files are
> still working, but iio-sensor-proxy is again not seeing any updates
> via the chardev(s). Any notion of what might be going on?
>
> Note that dmesg does contain (it always has):
>
> i2c_hid i2c-ITE8396:00: error in i2c_hid_init_report size:19 / ret_size:18
>
> but I have no idea if that's relevant to the IIO sensors? I was told
> in another thread that it shouldn't have any negative consequence.

Very strrange! After resuming from suspend this morning to check my
e-mail, it worked again! So maybe there is some bug/race still in the
init/suspend/resume path?

-Nish
