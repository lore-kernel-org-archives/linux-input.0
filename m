From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH 1/3] HID: logitech-hidpp: use devres to manage FF private data
Date: Mon, 14 Oct 2019 21:45:30 -0700
Message-ID: <CAHQ1cqHKy6TDiu8-=rG55FchccZirL1FZYMP2KuUxAud5k=0hA@mail.gmail.com>
References: <20191007051240.4410-2-andrew.smirnov@gmail.com> <20191014035417.4CE8F2083B@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191014035417.4CE8F2083B@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>, Sam Bazely <sambazley@fastmail.com>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Austin Palmer <austinp@valvesoftware.com>, linux-kernel <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sun, Oct 13, 2019 at 8:54 PM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>
> The bot has tested the following trees: v5.3.5, v5.2.20, v4.19.78, v4.14.148, v4.9.196, v4.4.196.
>
> v5.3.5: Build OK!
> v5.2.20: Build OK!
> v4.19.78: Failed to apply! Possible dependencies:
>     43cd97af70c65 ("HID: logitech: Stop setting drvdata to NULL on probe failure and remove")
>
> v4.14.148: Failed to apply! Possible dependencies:
>     43cd97af70c65 ("HID: logitech: Stop setting drvdata to NULL on probe failure and remove")
>
> v4.9.196: Failed to apply! Possible dependencies:
>     43cd97af70c65 ("HID: logitech: Stop setting drvdata to NULL on probe failure and remove")
>
> v4.4.196: Failed to apply! Possible dependencies:
>     43cd97af70c65 ("HID: logitech: Stop setting drvdata to NULL on probe failure and remove")
>     6c44b15e1c907 ("HID: logitech: check the return value of create_singlethread_workqueue")
>     7bfd2927adcac ("HID: hid-logitech-hidpp: Add basic support for Logitech G920")
>     7f4b49fef6ffb ("HID: hid-logitech-hidpp: Add range sysfs for Logitech G920")
>     af2e628d6be7a ("HID: logitech-hidpp: limit visibility of init/deinit functions")
>     ff21a635dd1a9 ("HID: logitech-hidpp: Force feedback support for the Logitech G920")
>
>
> NOTE: The patch will not be queued to stable trees until it is upstream.
>
> How should we proceed with this patch?

Please ignore this series, since it will be superseded by upcoming v2

Thanks,
Andrey Smirnov
