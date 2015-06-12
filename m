From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: [PATCH v5] Fix the resolution issue in ChromeOS
Date: Fri, 12 Jun 2015 12:02:26 +0200
Message-ID: <CAH6sp9NOgKA=NKx6yERCeHVhjHxPY=L38-p4wOU+us0xQz_Pag@mail.gmail.com>
References: <1432873649-32484-1-git-send-email-hn.chen@weidahitech.com>
	<CAH6sp9Ny3onDBaGEGUUGUMioG4OAiwy5RxantCjEqrYy-Qdcsw@mail.gmail.com>
	<1A63A1423E772B419A9D2E882CBCF6C401F3DB61@mail>
	<20150601181829.GB4469@bugger.home>
	<1A63A1423E772B419A9D2E882CBCF6C4020229A9@mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1A63A1423E772B419A9D2E882CBCF6C4020229A9@mail>
Sender: linux-kernel-owner@vger.kernel.org
To: Hn Chen <hn.chen@weidahitech.com>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org

On Wed, Jun 10, 2015 at 4:51 PM, Hn Chen <hn.chen@weidahitech.com> wrote:
> Hi, Frans,
>
>> Alright, I was just wondering. Seems like a waste to be waiting for something that's already finished ;-).
>> There's of course a risk that times may fluctuate between firmware versions. Did you take that into account in the code?
>> Or is there a hard maximum time for these operations defined for the firmware?
> Thanks for your reminding.
> After I check with the firmware guy, I will change the value of delay.
> What we do here is to read the data from flash and calculate their checksum and
> will cost about 6ms for 1024 bytes. So there is a delay for 10 ms per 1024 bytes.
> But in some situation, the controller will change it's running frequency(like do noise immunity),
> 10ms could be too margin.

Any chance this sort of thing could be detected?
