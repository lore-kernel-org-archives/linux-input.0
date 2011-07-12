From: Christopher Hudson <chris.hudson.comp.eng@gmail.com>
Subject: Re: [PATCH v5] input: Initial support for Kionix KXTJ9 accelerometer
Date: Tue, 12 Jul 2011 17:52:20 -0400
Message-ID: <CAB7Re7V6xru5ASUJp2ymo93Lbmtng6prUmdo9-r-wNBSokkhSQ@mail.gmail.com>
References: <1309288348-30735-1-git-send-email-chris.hudson.comp.eng@gmail.com>
	<20110704162628.GC8144@core.coreip.homeip.net>
	<CAB7Re7X=N8yCCOXvxMAgf8k0y+Mz_+YbJw58tjj69CP24YDhyw@mail.gmail.com>
	<20110705183917.GA15876@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:46503 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab1GLVwV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2011 17:52:21 -0400
Received: by pvg12 with SMTP id 12so4166519pvg.19
        for <linux-input@vger.kernel.org>; Tue, 12 Jul 2011 14:52:21 -0700 (PDT)
In-Reply-To: <20110705183917.GA15876@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-input@vger.kernel.org

Hi Dmitry,

I found a small bug in this driver when using the code as the basis
for testing another piece of hardware...I'm not sure how this got
through before:

+static int __devinit kxtj9_setup_input_device(struct kxtj9_data *tj9)
+{
+       struct input_dev *input_dev;
+       int err;
+
+       input_dev =3D input_allocate_device();
+       if (!tj9->input_dev) {
Should be:

if (!input_dev) {

if (!tj9->input_dev) always returns true in this context, thereby
always following the error path; you can see that nothing is assigned
to tj9->input_dev until after this check.

+               dev_err(&tj9->client->dev, "input device allocate faile=
d\n");
+               return -ENOMEM;
+       }
+
+       tj9->input_dev =3D input_dev;

Should I submit a small patch against your queued version to get this f=
ixed?

On Tue, Jul 5, 2011 at 2:39 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Tue, Jul 05, 2011 at 02:08:01PM -0400, Christopher Hudson wrote:
>> On Mon, Jul 4, 2011 at 12:26 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > Hi Chris,
>> >
>> > On Tue, Jun 28, 2011 at 03:12:28PM -0400, chris.hudson.comp.eng@gm=
ail.com wrote:
>> >> From: Chris Hudson <chudson@kionix.com>
>> >>
>> >> - Added Dmitry's changes
>> >> - Now using input_polled_dev interface when in polling mode
>> >> - IRQ mode provides a separate sysfs node to change the hardware =
data rate
>> >>
>> >
>> > I am not happy with the fact that this implementation forces users=
 to
>> > select polled or interrupt-driven mode at compile time. The patch =
I
>> > proposed had polled mode support optional and would automatically =
select
>> > IRQ mode for clients that have interrupt assigned and try to activ=
ate
>> > polled mode if interrupt is not available.
>> >
>> >> +
>> >> +/* kxtj9_set_poll: allows the user to select a new poll interval=
 (in ms) */
>> >> +static ssize_t kxtj9_set_poll(struct device *dev, struct device_=
attribute *attr,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 const char *buf, size_t count)
>> >> +{
>> >> + =A0 =A0 struct kxtj9_data *tj9 =3D i2c_get_clientdata(to_i2c_cl=
ient(dev));
>> >> +
>> >> + =A0 =A0 unsigned long interval;
>> >> + =A0 =A0 int ret =3D kstrtoul(buf, 10, &interval);
>> >> + =A0 =A0 if (ret < 0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> >> +
>> >> + =A0 =A0 mutex_lock(&tj9->lock);
>> >> + =A0 =A0 /* set current interval to the greater of the minimum i=
nterval or
>> >> + =A0 =A0 the requested interval */
>> >> + =A0 =A0 tj9->last_poll_interval =3D max((int)interval, tj9->pda=
ta.min_interval);
>> >> + =A0 =A0 mutex_unlock(&tj9->lock);
>> >
>> > This lock does not make sense. You are protecting update of last_p=
oll_interval
>> > field and this update can not be partial (i.e. only LSB or MSB is
>> > written) on all our arches, but you do not protect kxtj9_update_od=
r()
>> > which alters chip state and does need protection.
>> >
>> > I tried bringing forward my changes from the older patch into your=
s,
>> > please let me know if the patch below works on top of yours.
>>
>> Hi Dmitry,
>> Thanks for all your hard work, and yes it works fine. =A0There were =
a
>> couple of changes proposed by Jonathan that I had already merged int=
o
>> my version though; should I submit these in a separate patch or rese=
nd
>> the merged version?
>
> Cris,
>
> Could you please send the changes proposed by Jonathan as a separate
> patch relative to the v5 you posted earlier? Then I can fold v5, mine
> and your new patch together and queue the driver for 3.1.
>
> Thanks.
>
> --
> Dmitry
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
