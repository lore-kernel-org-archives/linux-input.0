From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] input: stmpe-ts: Add DT support for stmpe touchscreen
Date: Fri, 23 Nov 2012 16:49:31 +0530
Message-ID: <CAKohpon+iU93sviKrkR+sdCJk0Z6rz0FcvTNsh9Ap88+Qy2mVw@mail.gmail.com>
References: <f56ddb18f4e9c92f6a94c6d3ae3f5fe30e0bd892.1353652106.git.viresh.kumar@linaro.org>
	<20121123104620.GQ17471@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53991 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755660Ab2KWLTc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Nov 2012 06:19:32 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8785291oag.19
        for <linux-input@vger.kernel.org>; Fri, 23 Nov 2012 03:19:32 -0800 (PST)
In-Reply-To: <20121123104620.GQ17471@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>

On 23 November 2012 16:16, Lee Jones <lee.jones@linaro.org> wrote:
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/stmpe.txt
>> @@ -0,0 +1,43 @@
>> +STMPE Touchscreen
>> +----------------
>> +
>> +Required properties:
>> + - compatible: "st,stmpe-ts"
>
> You shouldn't be specifying a compatible string in the DT.
>
>> +Example:
>> +
>> +     stmpe_touchscreen {
>> +             compatible = "st,stmpe-ts";
>
> This needs to be removed.

Copying my earlier reply from stmpe-gpio patch for others to know
what i have to say on this :)

I believe these are required by the code you wrote in mfd-core.c

        if (parent->of_node && cell->of_compatible) {
                for_each_child_of_node(parent->of_node, np) {
                        if (of_device_is_compatible(np, cell->of_compatible)) {
                                pdev->dev.of_node = np;
                                break;
                        }
                }
        }

This matches compatible of child node with compatible of cell. And that's
why you have added that in your keypad mappings as well.

--
viresh
