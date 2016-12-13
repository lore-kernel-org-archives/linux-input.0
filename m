From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Tue, 13 Dec 2016 16:10:49 -0600
Message-ID: <CAL_Jsq+ApH0jn3YNPxqJ54ryYVmN781B_wHTwS8cT1Nf2ej0zw@mail.gmail.com>
References: <CAD=FV=UMonRe8WJ1feDv3Nh9g8hEGAwwFT5NYLbzXADBqhTf-A@mail.gmail.com>
 <20161208154145.GA30888@mail.corp.redhat.com> <CAL_Jsq+fdoFnarXYkPv6FjVue3v31ry-Ddfkq9fQk9Ek+AjETw@mail.gmail.com>
 <E409F66F-1E4B-4A63-9977-69DF44ACAB0A@gmail.com> <CAL_JsqKu0yhLVyEjcZs_rn=VqM9O4F_VMhOkfhEEvbYAjvWSTg@mail.gmail.com>
 <alpine.LNX.2.00.1612091532240.16984@cbobk.fhfr.pm> <CAL_JsqLpjhHeeKq3PmNToux1Rgkg0M84-dv9HGCOws223ima4w@mail.gmail.com>
 <alpine.LNX.2.00.1612120951130.16984@cbobk.fhfr.pm> <20161212100110.GA13907@mail.corp.redhat.com>
 <CAL_JsqJ7t=C4+PgCyNTev66V33-cyPkUHKsTcbnsYgvAaffVfw@mail.gmail.com> <20161212183422.GA138477@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932705AbcLMWLQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Dec 2016 17:11:16 -0500
In-Reply-To: <20161212183422.GA138477@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Mon, Dec 12, 2016 at 12:34 PM, Brian Norris <briannorris@chromium.org> wrote:
> Hi all,
>
> On Mon, Dec 12, 2016 at 08:47:06AM -0600, Rob Herring wrote:
>
> [Snip Benjamin's proposal; I agree we don't really want a multi-level DT
> layout purely for making the driver look a little nicer (I'm not sure
> this would really be nicer anyway). And I think, as Rob notes here, our
> disagreement is smaller than appears. But I might be wrong.]
>
>> Anyway, we're only debating this:
>
> OK, so I think we might have a consensus of sorts? I'll describe it
> here, in case I'm wrong. Otherwise, I'll send another rev.
>
>>          i2c-hid-dev@2c {
>>                  compatible = "wacom,w9013", "hid-over-i2c";
>
> I plan to document the above, but not treat "wacom,w9013" specially in
> the driver, apart from possibly listing it in the driver of_match_table.
> This was mentioned by Dmitry earlier, and I didn't see any objection.
>
> (Note that there are problems with module autoload when using multiple
> compatible strings like above. May not be supremely relevant to the
> documentation, but it *is* practically important.)

I'm not sure what is not working here exactly. We emit all the
compatible strings in the uevent. However, it looks like this is only
called for platform devices. In the case of i2c, I don't think any
compatible string is emitted. It looks to me like i2c_device_uevent
just needs a call to of_device_get_modalias to fix this. There's some
issues in the I2C core in how it does matching and maybe this is
related? I would guess if it was that easy, then it would be fixed
already. Maybe not.

>>                  reg = <0x2c>;
>>                  hid-descr-addr = <0x0020>;
>>                  interrupt-parent = <&gpx3>;
>>                  interrupts = <3 2>;
>>                  vdd-supply = <sth>;
>
> Document and support 'vdd-supply', optionally.
>
>>                  init-delay-ms = <100>;
>
> Per Rob's mention below, support this as 'post-power-on-delay-ms',
> optionally.
>
> We can use either of these properties on any device, with the
> intention that if there are future needs for divergent bindings, the
> aforementioned compatible property can help us differentiate.

TBC, from a DT perspective (and what the binding should say), is the
properties are only valid with a wacom compatible present (or any
others you want to add). If the driver doesn't enforce that and
supports having those properties with just "hid-over-i2c", then
downstream dts's can use that for all I care.

Rob
