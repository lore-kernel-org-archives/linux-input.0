From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH v2] hid-multitouch: changes from the review process
Date: Wed, 12 Jan 2011 14:01:00 +0100
Message-ID: <AANLkTimnY3QC+7tsGhHi8awkMYQTDH8ugn4U--qkmup4@mail.gmail.com>
References: <1294760754-7885-1-git-send-email-benjamin.tissoires@enac.fr>
	<20110111173511.GA3461@polaris.bitmath.org>
	<AANLkTin86WMvEpNAm2T8wR=GgUBtYqoqGJxZm7hKnEoE@mail.gmail.com>
	<20110112122741.GA29373@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110112122741.GA29373@polaris.bitmath.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Stephane Chatty <chatty@enac.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 12, 2011 at 1:27 PM, Henrik Rydberg <rydberg@bitmath.org> w=
rote:
> On Tue, Jan 11, 2011 at 06:38:24PM +0100, Benjamin Tissoires wrote:
>> On Tue, Jan 11, 2011 at 6:35 PM, Henrik Rydberg <rydberg@bitmath.org=
> wrote:
>> > On Tue, Jan 11, 2011 at 04:45:54PM +0100, Benjamin Tissoires wrote=
:
>> >> * amended Kconfig (PixCir and Hanvon are the same panel but with
>> >> =A0 different name)
>> >> * insert field name in mt_class and retrieving it in mt_probe
>> >> * add 2 quirks: MT_QUIRK_VALID_IS_INRANGE, MT_QUIRK_VALID_IS_CONF=
IDENCE,
>> >> =A0 in order to find the field "valid"
>> >> * inlined slot_is_contactid and slot_is_contact_number
>> >> * cosmetics changes (tabs and comments)
>> >> * do not send unnecessary properties once the touch is up
>> >>
>> >> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
>> >
>> > There are some syntactic suboptimalities in the resulting file tha=
t
>> > perhaps could be fixed, but content-wise, I have nothing further. =
So,
>> > given that it actually works,
>> >
>> > Acked-by: Henrik Rydberg <rydberg@euromail.se>
>> >
>> > Thank you very much for your work, Benjamin.
>>
>> Thanks for the review Henrik,
>
> Regarding the quanta patches you have pending, IFAICT the 0408:3001
> device is not properly supported currently, so perhaps that one could
> be added to the list, too.
>

Hi Henrik,

What do you mean by not properly supported?

the device is in hid-quanta since 2.6.33: commit "HID: add support for
Pixart Imaging Optical Touch Screen"

Cheers,
Benjamin
