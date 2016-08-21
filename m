From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: touchscreen: silead gsl1680: Document all compatibles
Date: Sun, 21 Aug 2016 15:11:52 -0700
Message-ID: <5BB13372-9C05-4FEB-85BC-E16BAE98EB77@gmail.com>
References: <1471424340-4201-1-git-send-email-hdegoede@redhat.com> <20160818193028.GA39271@dtor-ws> <CAL_JsqK2Lgic+-P-NvvnVO9COCy3k_yO3seOipYDd4d10QK2UA@mail.gmail.com> <20160818203959.GB39271@dtor-ws> <CAL_Jsq+juNdPXf8m7Nffb49uGc8uzpei9YA--8yP0oxrVhKPnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34412 "EHLO
        mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbcHUWMU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 Aug 2016 18:12:20 -0400
In-Reply-To: <CAL_Jsq+juNdPXf8m7Nffb49uGc8uzpei9YA--8yP0oxrVhKPnw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

On August 20, 2016 1:25:48 PM PDT, Rob Herring <robh+dt@kernel.org> wrote:
>On Thu, Aug 18, 2016 at 3:39 PM, Dmitry Torokhov
><dmitry.torokhov@gmail.com> wrote:
>> On Thu, Aug 18, 2016 at 02:48:52PM -0500, Rob Herring wrote:
>>> On Thu, Aug 18, 2016 at 2:30 PM, Dmitry Torokhov
>>> <dmitry.torokhov@gmail.com> wrote:
>>> > On Wed, Aug 17, 2016 at 10:59:00AM +0200, Hans de Goede wrote:
>>> >> The silead gsl1680 driver / binding supports a whole series of
>devices,
>>> >> list the compatibles for all of them in the binding.
>>> >>
>>> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> >> ---
>>> >> Changes in v2:
>>> >> -Drop the "silead,mssl1680" compatible thing, the "mssl1680" name
>is an
>>> >>  ACPI thing and does not belong in the dt bindings
>>> >> ---
>>> >>  .../devicetree/bindings/input/touchscreen/silead_gsl1680.txt    
>     | 4 ++++
>>> >>  1 file changed, 4 insertions(+)
>>> >>
>>> >> diff --git
>a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>>> >> index b0eca54..ad7f41a 100644
>>> >> ---
>a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>>> >> +++
>b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
>>> >> @@ -2,6 +2,10 @@
>>> >>
>>> >>  Required properties:
>>> >>  - compatible           : "silead,gsl1680"
>>> >> +                     or: "silead,gsl1688"
>>> >> +                     or: "silead,gsl3670"
>>> >> +                     or: "silead,gsl3675"
>>> >> +                     or: "silead,gsl3692"
>>> >
>>> > Hmm, why do we need to document all compatible strings? We usually
>have
>>> > only least common denominator in drievr, and device tree uses
>form:
>>> >
>>> >         compatible = "silead,<exact model>", "silead,gsl1680";
>>> >
>>> > Rob?
>>>
>>> Because we require them in dts files even if the OS only uses the
>fallback.
>>
>> So how exactly should it be documented? I mean if there were more
>than 1
>> OS they might have been using different fallbacks. How do we decide
>> which entry should be "true" fallback?
>
>It shouldn't matter which one an OS uses. There's typically only the
>specific one and then a generic or 1st compatible chip one.

When you are saying "first compatible chip" do you mean first as it was created by the vendor or first that was added to a given os? Because we quite often have no idea what the first compatible chip in a series was and start with whatever the first submitter of a driver used in their product.

>
>This is exactly why they need to be documented (and in a single place,
>looking at you u-boot), so there is no confusion as to what
>compatibles are allowed/valid for each platform.

What do you mean when you say platform?

We have uboot, core boot, Linux, free BSD, in whatever combinations. How do we make sure we all use the same fallback?


Thanks.

-- 
Dmitry
