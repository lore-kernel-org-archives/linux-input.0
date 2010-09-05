From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 0/5] input: wacom: Initial support for Bamboo (rev3)
Date: Sun, 5 Sep 2010 09:28:38 -0500
Message-ID: <AANLkTimMhAkdfNbju7ckFr-oSQrMcSTmX2sdstGMP_cb@mail.gmail.com>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>
	<AANLkTi=9F1HpUyhGOp0TJdazoshKgxbFkyqWvztb5OeH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=9F1HpUyhGOp0TJdazoshKgxbFkyqWvztb5OeH@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Sep 4, 2010 at 4:24 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Saturday, September 4, 2010, Henrik Rydberg <rydberg@euromail.se> =
wrote:
>> This the fourth iteration of the Bamboo patches. Hopefully no big
>> surprises. =A0The ordering has changed to allow setting the pressure=
_max
>> which is not parsed in the hid function. Ping's button mapping has
>> been implemented, relying on middle-button emulation instead. =A0The
>> lowres quirks now apply to all touch devices in the family.
>
> Thank you Henrik for the patchset. Very much appreciated.
>
> Acked-by: Ping Cheng < pingc@wacom.com> =A0for the series.
>
> Ping

Thanks for addressing my comments/questions.

Also, Thanks for placing all the hooks for future pen support as well.
 I'll be following up with a patch set for that once your finished.
If there are any remaining pen specific issues, feel free to offload
it on me.

Chris

>
>> Henrik Rydberg (4):
>> =A0=A0input: wacom: Add fuzz parameters to features
>> =A0=A0input: wacom: Collect device quirks into single function (rev2=
)
>> =A0=A0input: wacom: Add support for the Bamboo Touch trackpad (rev4)
>> =A0=A0input: wacom: Add a quirk for lowres Bamboo devices (rev2)
>>
>> Ping Cheng (1):
>> =A0=A0input: wacom: Parse the Bamboo device family
>>
>> =A0drivers/input/tablet/wacom.h =A0 =A0 | =A0 =A01 +
>> =A0drivers/input/tablet/wacom_sys.c | =A0 57 +++++++++++++-----
>> =A0drivers/input/tablet/wacom_wac.c | =A0123 +++++++++++++++++++++++=
++++++++++++++-
>> =A0drivers/input/tablet/wacom_wac.h | =A0 14 ++++
>> =A04 files changed, 176 insertions(+), 19 deletions(-)
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
