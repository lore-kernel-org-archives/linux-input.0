From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 2/4] Enabled Acer Launch Manager mode
Date: Mon, 6 Dec 2010 08:17:27 +0100
Message-ID: <AANLkTinW+Q+x17XDtyFN+nKhTh0VFLr+PDhzp6RUPT7H@mail.gmail.com>
References: <4CFD2740020000230002501B@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4CFD2740020000230002501B@novprvlin0050.provo.novell.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: dmitry.torokhov@gmail.com, Takashi Iwai <tiwai@novell.com>, mjg@redhat.com, mjg59@srcf.ucam.org, carlos@strangeworlds.co.uk, jbenc@suse.cz, jdelvare@suse.de, trenn@suse.de, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

>>
>> Just noticed - this function (and others similar to this in your
>> subsequent patces) mixes acpi-style return values (acpi_status) with
>> Linux ones (-ERRXXX). You need to pick one standard (I'd advocate Linux
>> style) and stick with it.
>>
>
> Thank's for your review and suggestion, I choice use acpi-style because
> it don't need change too much and old functions in acer-wmi also follow
> acpi-style.
> I replaced the -EINVAL with AE_ERROR, the following is new patch. If it's OK,
> I will modify patch 2/4 and patch 3/4 then re-send patchset again.
>
>

But if you use acpi-style errors won't be able to go back to the user (errno)
and userspace programs won't be able to display appropriate errors (on modprobe,
manipulating sysfs files, etc...). I didn't read the code, so it may
not be an issue here,
but you should check that meaningful error codes are sent back to userspace.

-- 
Corentin Chary
http://xf.iksaif.net
