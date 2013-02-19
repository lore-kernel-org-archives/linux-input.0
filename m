From: Yufeng Shen <miletus@google.com>
Subject: Re: atmel_mxt_ts and mxt224e
Date: Tue, 19 Feb 2013 15:43:40 -0500
Message-ID: <CAPDwgkPjhTMjS=V33u_JLx5H4sFEOUif_xgu-fz9BHYmPdO11g@mail.gmail.com>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
	<CAPDwgkPBmH3wTDs=t5uaj6jpK6hYD0mxJJ3-5d=Fv2W9aZ3dPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:33295 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933973Ab3BSUnm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Feb 2013 15:43:42 -0500
Received: by mail-vb0-f46.google.com with SMTP id b13so4496882vby.5
        for <linux-input@vger.kernel.org>; Tue, 19 Feb 2013 12:43:41 -0800 (PST)
In-Reply-To: <CAPDwgkPBmH3wTDs=t5uaj6jpK6hYD0mxJJ3-5d=Fv2W9aZ3dPQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, y0922.shim@samsung.com, Benson Leung <bleung@chromium.org>

re-sent due to delivery failure on HTML tags.


On Tue, Feb 19, 2013 at 3:41 PM, Yufeng Shen <miletus@chromium.org> wrote:
>
> Hi Peter,
>
> The Chromium team has been recently working on the atmel_mxt_ts driver extensively
> (see patches history here
> http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=history;f=drivers/input/touchscreen/atmel_mxt_ts.c;h=5e40f6d75e7f7e24370e3a7d266c6ebcc06b46a6;hb=refs/heads/chromeos-3.4)
>
> As you pointed out, the chip configuration process and mxt_handle_pdata() is very fragile regarding
> different chip sets with different object layouts. So we have taken the approach to move to file based
> configuration (see patch
> http://git.chromium.org/gitweb/?p=chromiumos/third_party/kernel.git;a=commit;h=95a1d96b785af4e16138e6cc7b4d01fed5b9dccb)
>
> So the platform data are moved to a config file with predefined format. Userspace can interact with the driver
> through sysfs to initiate loading a particular config file for the device. When configuration happens, config file chip ID & chip info
> block CRC are compared against the device chip ID & device chip info block to make sure the consistence between
> the config and the chip set. Then the configuration is written to the device dynamically which does not require the device reboot.
>
> Other works include exposing various FW/config attributes through sysfs, e.g. FW version and config CRC, which can be used
> for FW/config version controlling.
>
> We have been using and testing this approach for a long time and now in the process of upstreaming our patch set, so to avoid duplicate effort, it would be great if you can give some thoughts (or try out the patch set if you are interested and we would give you all the help as
> we can) on our patch set and let us iterate on it.
>
> Let me know what you think.
>
> Thanks,
>
> --- Yufeng Shen
>
>
>
>
>
> On Thu, Feb 7, 2013 at 9:17 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
>>
>> Hello,
>>
>> I had some issues in using the atmel_mxt_ts driver with different mxt224 parts
>> (different firmware version, mxt224 vs. mxt224); configuration of the chip
>> via mxt_platform_data.config is super-fragile when device objects change
>>
>> mxt_handle_pdata() assumes that certain object table entries are present and
>> fails on the mxt224e
>>
>> the patch series aims to support the mxt224e better and adds a message to detect
>> inconsistencies between config data and the device object table
>>
>> if there is interest I can propose a more robust mechanism to set the config data;
>> similar patches are floating around for Android in various trees
>>
>> thanks, regards, p.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-input" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
