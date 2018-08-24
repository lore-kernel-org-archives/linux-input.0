From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/6] HID: generic: create one input report per
 application type
Date: Fri, 24 Aug 2018 08:44:51 -0700
Message-ID: <CAKdAkRRsca1Q2Ltqr=yyZ-rr7vxkty1cGVYjFB5bcC87UtWDSw@mail.gmail.com>
References: <20180424080437.21367-1-benjamin.tissoires@redhat.com> <20180424080437.21367-3-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180424080437.21367-3-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, Mario Limonciello <Mario.Limonciello@dell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin, Jiri,

On Tue, Apr 24, 2018 at 1:04 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> It is not a good idea to try to fit all types of applications in the
> same input report. There are a lot of devices that are needing
> the quirk HID_MULTI_INPUT but this quirk doesn't match the actual HID
> description as it is based on the report ID.
>
> Given that most devices with MULTI_INPUT I can think of split nicely
> the devices inputs into application, it is a good thing to split the
> devices by default based on this assumption.
>
> Also make hid-multitouch following this rule, to not have to deal
> with too many input created.
>
> While we are at it, fix some checkpatch complaints about converting
> 'unsigned' to 'unsigned int'.
>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---

I see a spike of user reports on Bugzilla with HID devices being
broken on 4.18 that seem to point to this commit. For example:
https://bugzilla.kernel.org/show_bug.cgi?id=200849

Thanks.

-- 
Dmitry
