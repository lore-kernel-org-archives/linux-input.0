From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v3] HID: asus: support backlight on USB keyboards
Date: Wed, 12 Apr 2017 22:13:55 +0200
Message-ID: <CAL9uMOGfHPiHihFXAYvLU06Jcd9hRQwQve2b=XsLOzHavTBhOA@mail.gmail.com>
References: <20170406101817.14699-1-carlo@caione.org> <20170410063907.GA20349@mail.corp.redhat.com>
 <CAL9uMOFYk5ru3P96xVTyH_ayq6jiOhn7E1wXLH-BsahYtXP2JA@mail.gmail.com> <alpine.LSU.2.20.1704122211390.28004@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LSU.2.20.1704122211390.28004@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Carlo Caione <carlo@caione.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 12, 2017 at 10:12 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Wed, 12 Apr 2017, Carlo Caione wrote:
>
>> >> +     ret = devm_led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);
>> >> +     if (ret < 0) {
>> >> +             /* No need to have this still around */
>> >> +             devm_kfree(&hdev->dev, drvdata->kbd_backlight);
>> >> +             cancel_work_sync(&drvdata->kbd_backlight->work);
>> >
>> > Small nitpick, you don't need to call cancel_work_sync() here, nobody
>> > could have called a worker. But OTOH, it doesn't hurt.
>> >
>> > Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>
>> Thanks Benjamin. Who should pick this up?
>
> I am going to.
>
> I'll drop the cancel_work_sync() call while doing it, ok?

Sure, go for it.

Thank you,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
