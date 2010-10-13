From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 4/5] input: wacom: Add support for the Bamboo Touch
 trackpad (rev4)
Date: Wed, 13 Oct 2010 15:50:11 -0500
Message-ID: <AANLkTikdfWc3GG8TPjgkkK9CT0RTEg-FdNAWLg9REyKn@mail.gmail.com>
References: <1283607783-29388-1-git-send-email-rydberg@euromail.se>
	<1283607783-29388-5-git-send-email-rydberg@euromail.se>
	<AANLkTikpAfeSgCsaBWPcW7EncbW7UtLVjH=bpmmbVU-7@mail.gmail.com>
	<4CB5F8B3.6010504@euromail.se>
	<AANLkTi=RZ5OmBBOV2=kYJ+wE2GD1N9ZKMNyKGVvFqwiR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63961 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764Ab0JMUuM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 16:50:12 -0400
Received: by gxk6 with SMTP id 6so1169189gxk.19
        for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 13:50:11 -0700 (PDT)
In-Reply-To: <AANLkTi=RZ5OmBBOV2=kYJ+wE2GD1N9ZKMNyKGVvFqwiR@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Wed, Oct 13, 2010 at 3:15 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> On Wed, Oct 13, 2010 at 11:21 AM, Henrik Rydberg <rydberg@euromail.se> wrote:
>> In my mind, these are buttons just like the buttons on any mouse or trackpad.
>
> For this particular model, it might be fine. My concern is for the other models.
>
>> Regarding remapping, I think it matters if buttons have strong or weak semantics.
>
> Supporting button remapping is not a question. It is a decision. The
> question is how. I hate to open this can of worms even now. But, we do
> have to face the reality.
>
> Currently, I use BTN_TOOL_FINGER to group those buttons together and
> to pass them to the userland. This has never been an issue before MT
> became such a hot topic. Now, we need to EITHER choose a new
> BTN_TOOL_something to pass the poor buttons to the userland OR use the
> kernel approach that Dmitry suggested. I am open to all suggestions
> although I feel passing the buttons to the userland is a
> better/cleaner solution.
>
> My goal is to get a consensus so no one can blame me or the maintainer
> for the decision :). Fair?
>

Let me first throw out that I think the kernel side solution can be
complementary to user side solutions as well.  We may wish to do it in
both places.

I plan to have some patches to xf86-input-wacom in next week or so
related to this topic.

One thing on kernel side is we should try to keep two set classes of
buttons and not mix their meanings to help out user land.

1) Those buttons that are known to be located on a stylus (BTN_STYLUS
and BTN_STYLUS2)
2) Those buttons that are part of a tablet/touchpad (BTN_LEFT/BTN_RIGHT/etc).

For class #1, there is an implied meaning that when tool goes out of
proximity that its buttons also go out of proximity (user land is
required to do button releases for some known cases the kernel driver
doesn't clear class #1 buttons).  For class #2, they are just always
there and have valid meaning.  So my point is keep in mind to not use,
for example, BTN_STYLUS for buttons that should always work.

For Bamboo Touch, I think we chose class #2 BTN_* for tablet buttons
which will help us in user land.

My basic plan for xf86-input-wacom is to decide on a per event which
tracking buffer to store event in instead of deciding per sync window
as its done today.  For class #1 events, it will be stored like today.
 For class #2 buttons/events, it will be stored in buttons buffer
(which happens to already exists) as if BTN_TOOL_FINGER was sent.

Then 1 or 2 buffers are posted each sync window depending on which were updated.

Its my same basic plan for 2nd finger of MT as well which means
between 1 and 3 buffers will be posted each sync window.

If this approach is accepted then you get normal xf86-input-wacom
button remapping features.

Chris
