From: Ferruh Yigit <fery@cypress.com>
Subject: Re: [PATCH 2/4] Input: cyttsp4 - core driver for Cypress TMA4XX touchscreen
 devices
Date: Mon, 27 Aug 2012 08:49:40 +0300
Message-ID: <503B0A74.9070809@cypress.com>
References: <Ferruh Yigit <fery@cypress.com> <1344345000-30494-1-git-send-email-fery@cypress.com> <50378DD1.9080806@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50378DD1.9080806@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin McNeely <kev@cypress.com>, Javier Martinez Canillas <javier@dowhile0.org>, Henrik Rydberg <rydberg@euromail.se>, Shawn Landden <shawnlandden@gmail.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Olivier Sobrie <olivier@sobrie.be>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On 08/24/2012 05:21 PM, Michal Marek wrote:
> Dne 7.8.2012 15:09, Ferruh Yigit napsal(a):
>> +static int __init cyttsp4_core_init(void)
>> +{
>> +       int rc = 0;
>> +
>> +       rc = cyttsp4_register_core_driver(&cyttsp4_core_driver);
>> +       pr_info("%s: Cypress TTSP v4 core driver (Built %s @ %s) rc=%d\n",
>> +                __func__, __DATE__, __TIME__, rc);
> Hi,
>
> please drop the __DATE__ and __TIME__ macros to keep the build
> deterministic.
>
> thanks,
> Michal

Thank you Michal,

Will replace them with fixed release date macro.

Regards,
ferruh

--

Regards,
ferruh


This message and any attachments may contain Cypress (or its subsidiaries) confidential information. If it has been received in error, please advise the sender and immediately delete this message.
