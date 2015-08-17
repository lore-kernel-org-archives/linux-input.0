From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] input: gpio_keys: Don't report events on gpio failure
Date: Mon, 17 Aug 2015 15:59:59 +0900
Message-ID: <CAAVeFuK6TwYrbb8DJWa8NgL269p03vmDVDVaSuEvCWuOuN4GzA@mail.gmail.com>
References: <1438048204-632-1-git-send-email-bjorn.andersson@sonymobile.com>
 <20150728210040.GE19610@dtor-ws> <20150810224109.GN6519@usrtlx11787.corpusers.net>
 <CACRpkdY8KqKa3GpfNo5JQAO5+Z3UG0J99VCg_OjsRTa5MJAaYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CACRpkdY8KqKa3GpfNo5JQAO5+Z3UG0J99VCg_OjsRTa5MJAaYg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 13, 2015 at 10:06 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Aug 11, 2015 at 12:41 AM, Bjorn Andersson
> <bjorn.andersson@sonymobile.com> wrote:
>
>> But then the question first goes to Linus & co.
>>
>> gpio_chip->get() can return a negative value to indicate errors (and did
>> so in this case), all parts of the API seems indicates that we can get
>> an error (int vs bool).
>
> Ooops.
>
>> Should we change _gpiod_get_raw_value() to propagate this error?
>
> Yes for now. Can you patch it? :)
>
>>  Or
>> should we just ignore this issue and propagate an error as GPIO high
>> reading?
>
> I don't know about the future. In some sense GPIOs are so smallish
> resources that errorhandling every call to read/write them seem to
> be a royal PITA. That is why I wanted to switch them to bool and get
> rid of the problem, but now I also see that maybe that was not such a
> smart idea, if errors do occur on the set/get_value path.

Nowadays GPIOs may reside at the other end of an i2c bus, which means
that even the simplest operation like reading a GPIO value can
potentially fail. And it will probably not get better - wait until we
implement GPIO-over-IP! :)

So I'd say it makes sense to propagate errors returned by the driver's
get() hook. This might contradict some of our earlier statements about
simplifying the GPIO API, but is preferrable to having to make a
decision as to which valid value to return if the driver fails...

It should then be made very clear in the documentation that the only
positive values ever returned by the GPIO API will be 0 and 1 (we
already have a clamping mechanism for that IIRC), and that negative
values are propagated as-is.

Linus, does that seem reasonable to you? Does anyone has the intention
to address that one or should I add it to my short-term TODO list?
