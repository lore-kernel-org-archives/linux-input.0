From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH V5 14/14] input: cyapa: add function to monitor LID close
 event to off trackpad device
Date: Tue, 9 Sep 2014 13:09:13 +0800
Message-ID: <CANLzEku4fxNbNQ6fufpAvQ2YWnZ1gpZZugxZm2xbguTAm+_q-g@mail.gmail.com>
References: <54003b5a.ac26460a.73fc.ffffe939@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54003b5a.ac26460a.73fc.ffffe939@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dudley Du <dudley.dulixin@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, patrik@google.com, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Dudley,


On Fri, Aug 29, 2014 at 4:35 PM, Dudley Du <dudley.dulixin@gmail.com> wrote:
> Add the function to monitor lid close event to suspend and resume
> trackpad device.
> Because system suspend takes some time to trigger from user space,
> and in that time, the lid panel of the laptop may couple with the
> active trackpad. This may generate stray input events, which may
> in turn cancel the suspend if the drivers use pm_wakup_event(), and
> those input events may trigger something unwanted in the UI.
> So this patch adds the function to do off the trackpad device quickly.
> When the lid is closed, as soon as possible, the trakcpad device must
> be off. And furthermore, the policy on lid close is not always to
> enter suspend (lid closed with external display), and at this time,
> the trackpad device must be disabled as well as again to avoid the
> risk of generating stray events.
> TEST=test on Chromebooks.
>
> Signed-off-by: Dudley Du <dudl@cyrpess.com>

So, I think for the chromeos-kernel, we are moving away from this hack
lid filter solution. Very soon we'll remove this in favor of something
else, so my suggestion would be to drop this from your patch series.



-- 
Benson Leung
Software Engineer, Chrome OS
Google Inc.
bleung@google.com
