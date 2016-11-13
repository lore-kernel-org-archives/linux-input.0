From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 0/3] Input: ALPS - Bug fix and cleanup for SS5 hardware
Date: Sat, 12 Nov 2016 22:43:35 -0800
Message-ID: <CAKdAkRTy437SMLS0EYtAnYG4Dg_Us_8X56k4AQ9LLb+eYtx7Qg@mail.gmail.com>
References: <20161110151942.GA3969@pali> <201611120203.44330@pali>
 <20161112010640.GA37875@dtor-ws> <201611121329.26484@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34193 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932150AbcKMGnh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 13 Nov 2016 01:43:37 -0500
Received: by mail-ua0-f193.google.com with SMTP id b35so3740573uaa.1
        for <linux-input@vger.kernel.org>; Sat, 12 Nov 2016 22:43:36 -0800 (PST)
In-Reply-To: <201611121329.26484@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Paul Donohue <linux-kernel@paulsd.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ben Gamari <ben@smart-cactus.org>, Michal Hocko <mhocko@suse.com>

On Sat, Nov 12, 2016 at 4:29 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wro=
te:
> On Saturday 12 November 2016 02:06:40 Dmitry Torokhov wrote:
>> On Sat, Nov 12, 2016 at 02:03:42AM +0100, Pali Roh=C3=A1r wrote:
>> > On Saturday 12 November 2016 01:56:21 Dmitry Torokhov wrote:
>> > > On Fri, Nov 11, 2016 at 02:59:09PM +0100, Pali Roh=C3=A1r wrote:
>> > > > On Thursday 10 November 2016 17:44:43 Paul Donohue wrote:
>> > > > > This series includes a bug fix and assorted cleanup for the
>> > > > > Alps SS5 (SS4 v2) code.
>> > > > >
>> > > > > Changes in v5:
>> > > > > * Moved TrackStick decoding logic to
>> > > > > alps_process_packet_ss4_v2() to
>> > > > >
>> > > > >   make the code more consistent with other protocol versions
>> > > > >   (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
>> > > > >
>> > > > > Changes in v4:
>> > > > > * Fixed patch formatting issues
>> > > > > * Correct casting issues in macros added in v3
>> > > > >
>> > > > > Changes in v3:
>> > > > > * Added additional code cleanup to make the code easier to
>> > > > > understand
>> > > > >
>> > > > >   (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
>> > > > >
>> > > > > Changes in v2:
>> > > > > * For consistency with other Alps functions, check packet
>> > > > > bytes for
>> > > > >
>> > > > >   packet type rather than adding a flag to alps_fields for
>> > > > >   packet
>> > > > >
>> > > > > type. (Suggested by Pali Roh=C3=A1r <pali.rohar@gmail.com>)
>> > > > >
>> > > > > Paul Donohue (3):
>> > > > >   Input: ALPS - Fix TrackStick support for SS5 hardware
>> > > > >   Input: ALPS - Clean up TrackStick handling for SS5 hardware
>> > > > >   Input: ALPS - Clean up code for SS5 hardware
>> > > > >
>> > > > >  drivers/input/mouse/alps.c | 59
>> > > > >
>> > > > > +++++++++++++++++++++++++---------------------
>> > > > > drivers/input/mouse/alps.h | 22 ++++++++++++++++-
>> > > > >
>> > > > >  2 files changed, 53 insertions(+), 28 deletions(-)
>> > > >
>> > > > Whole patch series looks fine.
>> > > > You can add my Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
>> > >
>> > > FYI: I do not see a dingle email from Paul, only your replies.
>> >
>> > Patches were sent to linux-input@vger.kernel.org ML. Maybe some
>> > spam filter ate emails? Btw I added you to receivers of my last
>> > sent email.
>>
>> Yes, I looked there as well and did not see anything but you replies.
>>
>> Thanks.
>
> Do you need to resend patches? Or have you already found them?
>

Hmm, was the latest v5? I see https://patchwork.kernel.org/patch/9421473/

It looks like Paul is running his own mailserver on what looks like
Verizon IP pool, which in this day and age likely makes gmail drop his
mails.

Thanks.

--=20
Dmitry
