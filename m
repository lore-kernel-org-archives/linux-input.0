From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 5.4 regression fix] Input: soc_button_array - partial
 revert of support for newer surface devices
Date: Sat, 5 Oct 2019 22:14:51 +0200
Message-ID: <ef31abf6-b3f2-f3aa-1536-3ecd5fc819e1@redhat.com>
References: <20191005105551.353273-1-hdegoede@redhat.com>
 <222c364a-bc2b-5960-3fe4-7d1ce222e3e2@gmail.com>
 <96cea5be-d285-8323-1ab2-9c8e87993165@redhat.com>
 <65b265d2-f7a8-bcd7-e63f-f8efb7349324@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65b265d2-f7a8-bcd7-e63f-f8efb7349324@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Maximilian Luz <luzmaximilian@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko <andy@infradead.org>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 05-10-2019 17:01, Maximilian Luz wrote:
> Hi, again
>=20
> On 10/5/19 3:20 PM, Hans de Goede wrote:
>> Ok, on x86 the GPIO drivers really should all be builtin because
>> various ACPI methods including device D0 / D3 (power-on/off) methods
>> may depend on them. So normally this should never happen.
>>
>> If this (-EPROBE_DEFER on surface devices) somehow still is happening
>> please let me know and we will figure something out.
>=20
> I have never personally experienced this, only received reports which
> indicated this and that the change (as well as manually reloading
> soc_button_array) fixed it. I will come back to you if I hear anything
> in regards to this again.
>=20
> I have now also tested your patch on the Surface Book 2. Does not cause
> any issues as far as I can tell.
>=20
> Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
>=20
> And if that is needed/wanted
>=20
> Acked-by: Maximilian Luz <luzmaximilian@gmail.com>

Great, thank you.

Regards,

Hans
