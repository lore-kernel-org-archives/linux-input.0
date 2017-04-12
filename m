From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v3] HID: asus: support backlight on USB keyboards
Date: Wed, 12 Apr 2017 10:50:16 +0200
Message-ID: <CAL9uMOFYk5ru3P96xVTyH_ayq6jiOhn7E1wXLH-BsahYtXP2JA@mail.gmail.com>
References: <20170406101817.14699-1-carlo@caione.org> <20170410063907.GA20349@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170410063907.GA20349@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Carlo Caione <carlo@caione.org>, jikos@kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Mon, Apr 10, 2017 at 8:39 AM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Apr 06 2017 or thereabouts, Carlo Caione wrote:

>> +     ret = devm_led_classdev_register(&hdev->dev, &drvdata->kbd_backlight->cdev);
>> +     if (ret < 0) {
>> +             /* No need to have this still around */
>> +             devm_kfree(&hdev->dev, drvdata->kbd_backlight);
>> +             cancel_work_sync(&drvdata->kbd_backlight->work);
>
> Small nitpick, you don't need to call cancel_work_sync() here, nobody
> could have called a worker. But OTOH, it doesn't hurt.
>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Thanks Benjamin. Who should pick this up?

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
