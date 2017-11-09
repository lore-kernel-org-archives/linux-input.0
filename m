From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: generic: Recognize WACOM_HID_WD_PEN as a type
 of pen collection
Date: Thu, 9 Nov 2017 08:54:41 -0800
Message-ID: <CANRwn3T4nvxMGxExtw+QG4msZnd1BUsEH51YCFVuv2j7ob97Ag@mail.gmail.com>
References: <20171018152713.22633-1-killertofu@gmail.com> <nycvar.YFH.7.76.1710191021420.9294@jbgna.fhfr.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <nycvar.YFH.7.76.1710191021420.9294@jbgna.fhfr.qr>
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "# v3.17+" <stable@vger.kernel.org>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 19, 2017 at 1:22 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 18 Oct 2017, Jason Gerecke wrote:
>
>> The WACOM_PEN_FIELD macro is used to determine if a given HID field shou=
ld be
>> associated with pen input. This field includes several known collection =
types
>> that Wacom pen data is contained in, but the WACOM_HID_WD_PEN applicatio=
n
>> collection type is notably missing. This can result in fields within thi=
s
>> kind of collection being completely ignored by the `wacom_usage_mapping`
>> function, preventing the later '*_event' functions from being notified a=
bout
>> changes to their value.
>>
>> Fixes: c9c095874a ("HID: wacom: generic: Support and use 'Custom HID' mo=
de and usages")
>> Fixes: ac2423c975 ("HID: wacom: generic: add vendor defined touch")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
>
> Applied to for-4.14/upstream-fixes
>
> --
> Jiri Kosina
> SUSE Labs
>

Was this branch ever sent to Linus? I don't see any mention of it (or
this patch) in the 4.14-rc8 history...

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....
