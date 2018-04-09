From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Silently fail probe for CHPN0001
 touchscreen
Date: Mon, 9 Apr 2018 17:07:15 +0000
Message-ID: <20180409170713.GE2341@sasha-vm>
References: <20180403131634.13187-2-hdegoede@redhat.com>
 <MW2PR2101MB1034700D2EE61E78EA6C13E7FBBA0@MW2PR2101MB1034.namprd21.prod.outlook.com>
 <585b5f34-8b00-bf84-5b99-fa204a3e3e75@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <585b5f34-8b00-bf84-5b99-fa204a3e3e75@redhat.com>
Content-Language: en-US
Content-ID: <AA5CA3B780C61A4A914CA581183930CB@namprd21.prod.outlook.com>
Sender: stable-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Apr 07, 2018 at 11:42:03AM +0200, Hans de Goede wrote:
>Hi,
>
>On 06-04-18 22:05, Sasha Levin wrote:
>>Hi,
>>
>>[This is an automated email]
>>
>>This commit has been processed by the -stable helper bot and determined
>>to be a high probability candidate for -stable trees. (score: 20.8863)
>>
>>The bot has tested the following trees: v4.16, v4.15.15, v4.14.32, v4.9.9=
2, v4.4.126.
>>
>>v4.16: Build OK!
>>v4.15.15: Build OK!
>>v4.14.32: Build OK!
>>v4.9.92: Failed to apply! Possible dependencies:
>>     94116f8126de ("ACPI: Switch to use generic guid_t in acpi_evaluate_d=
sm()")
>>
>>v4.4.126: Failed to apply! Possible dependencies:
>>     94116f8126de ("ACPI: Switch to use generic guid_t in acpi_evaluate_d=
sm()")
>
>Cool, first time I see this bot in action, nice work.

I'll leave it out, thanks!

>>Please let us know if you'd like to have this patch included in a stable =
tree.
>
>So FWIW this commit is NOT stable material (it cannot hurt, but it is not
>necessary). This commit really only makes sense together with a new touchs=
creen
>driver which does actually know how to handle the CHPN0001 touchscreen.
>
>For future mails like this, do I understand the mail correctly that if I
>do NOT want a patch picked up by the -stable helper bot to go to stable
>I do not have to do anything?

I would probably try and pick it up without an ack. If possible, even a
brief "no" reply if you don't want it in stable would be great. Thanks!=
