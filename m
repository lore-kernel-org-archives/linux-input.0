From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: Fragmentation of Samsung SoC code (was INPUT][KEYBOARD] Add new
	keypad driver for s3c series SoCs)
Date: Mon, 7 Sep 2009 17:32:08 +0900
Message-ID: <9c9fda240909070132u64df987cydd5cfacec989819@mail.gmail.com>
References: <00b101ca2e30$84135d90$8c3a18b0$%yang@samsung.com>
	 <9c9fda240909062025h6400686ema7b5c64937168fbc@mail.gmail.com>
	 <20090907062658.GS3962@prithivi.gnumonks.org>
	 <9c9fda240909062359s1629f7a4p65717ad07dcc22ca@mail.gmail.com>
	 <20090907080202.GW3962@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:42700 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbZIGIcH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Sep 2009 04:32:07 -0400
Received: by vws33 with SMTP id 33so1677531vws.33
        for <linux-input@vger.kernel.org>; Mon, 07 Sep 2009 01:32:08 -0700 (PDT)
In-Reply-To: <20090907080202.GW3962@prithivi.gnumonks.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: =?UTF-8?B?7JaR7KeE7ISx?= <jsgood.yang@samsung.com>, linux-input@vger.kernel.org, ben-linux@fluff.org, =?EUC-KR?B?seiw5sDPL0FQsLO538bAL0UzL7vvvLrA/MDa?= <ki0351.kim@samsung.com>, =?EUC-KR?B?seixucH4L0FQsLO538bAL0U1L7vvvLrA/MDa?= <kgene.kim@samsung.com>

2009/9/7 Harald Welte <laforge@gnumonks.org>:
> Hi Kyungmin,
>
> On Mon, Sep 07, 2009 at 03:59:41PM +0900, Kyungmin Park wrote:
>> > System LSI's kernel tree is on git.kernel.org and updated every ni=
ght, so you
>> > (or other interested parties) can stay up-to-date with what is hap=
pening. =A0If
>> > you base your work on top of System LSI's tree, you would always f=
ollow their
>> > work. =A0System LSI's tree is what is scheduled to be submitted to=
 mainline.
>>
>> Even though it's working at Samsung SoCs. but it's not mean it fits
>> the mainline kernel. =A0It's based on SMDK board and focused on SMDK=
=2E
>>
>> I mean it's not generic. Some codes are hard-coded and don't call
>> proper frameworks APIs. especially clocks
>
> Yes, I agree wity you. =A0Some customers of those SoCs who use Linux =
also agree :)
>
> This is why the System LSI team needs your input based on your experi=
ence!
>
> They will merge your patches if you send them! =A0They will learn as =
much from
> you, as they are from me when I provide feedback.

It's already sent by Joonyoung,

>
>> >> I will post the our works.
>> >
>> > I'm not sure if two different Samsung departments posting competin=
g drivers to
>> > the mainline mailing lists will really help. =A0You need to define=
 which group
>> > will be the 'master' inside Samsung (the logical choice would be S=
ystem LSI).
>>
>> It's simple. give a choice to customers if there are two versions. y=
ou
>> think it's some duplicated works it's better to others.
>
> Don't you think it is weird to see two different Samsung groups dupli=
cating
> each others work, creating fragmentation and confusion? =A0Each drive=
r will have
> its own bugs and or problems, and right now neither your driver nor S=
ystem
> LSI's driver is in mainline.
>
> So rather than continue to try to compete with each other, you need t=
o work
> together. =A0If you think your code is superior, why not submit your =
code as
> patches to System LSI, or even ask System LSI if you can either

It's because we don't get same base code. LSI works on s3c6410, but we
s3c6410, s5pc100 and s5pc110.
we trying to post the patches related with s3c6410 but it takes long
time to merge to Ben's git.
at that we start the s5pc1xx series works.

Anyway. please let me know which the next patch. touchscreen? or others=
?

Than we can compare the devices sources and discuss internally and then=
 post it.

>
> 1) get commit access to system lsi's git tree
> or
> 2) send pull requests to system LSI and ask them to pull from your tr=
ee.
>
> Everyone has limited resources. =A0System LSI, your team, anyone in t=
he
> community.
>
> The point is that everyone needs to work together. =A0There needs to =
be a clear
> definition of the process, i.e. who will work on what, based on which=
 tree.
> Hwo will submit what mainline, and who will maintain which driver aft=
er it has
> been merged in mainline..
>
> The fragmentation between many different trees with each their own se=
t of
> drivers (let's say so far: Ben dooks / mainline, your code, System LS=
I's code)
> is creating a complexity and maintenance nightmare that nobody can de=
al with
> in the long term.
>
> I understand that System LSI was probably the root cause of this prob=
lem
> due to their lack of understanding of this process. =A0But this has c=
hanged
> now.
>
> It is not "they" vs. "you" vs. "us", it is all of us together. =A0The=
re is too
> much work to be done. =A0There is 6400,6410,6440,6430,6442,c100,c110 =
and more
> products lining up in the future. =A0Many drivers spanning various su=
bsystems.
> Only if the resources are put together this task can be finished in a=
ny
> reasonable amount of time.

That's reason to send our codes. Now you focus on the s3c6410 but we
already know the s5pc1xx series.
Please consider it at this work. why does it work twice.

>
> The Linux-aware customer wants to grab one tree (preferrably mainline=
)
> that has all the drivers/features for all SoCs. =A0He doesn't want to=
 look
> at 5 different trees, test them, select what he wants and then manual=
ly go
> merging bits and pieces from each of them.
>
>> I don't hope just push their codes to mainline with these discussion=
=2E
>

with -> without

> Sorry, I don't understand what you're saying here.
>
> System LSI is pushing their code for mainline, one patch at a time, l=
ike
> we are seeing with this keypad driver right now. =A0This will generat=
e feedback
> by the community (including you). =A0System LSI then incorporates tha=
t feedback
> and re-submit an updated version of the driver - just like any other =
person
> who submits code to Linux mainline.
>

I think no problem to send several patch or drivers parallel. If so we
can get more feedbacks.

Thank you,
Kyungmin Park
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
