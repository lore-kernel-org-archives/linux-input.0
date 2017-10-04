From: =?UTF-8?Q?=c5=81ukasz_Majewski?= <l.majewski@majess.pl>
Subject: Re: [Regulator] Request for clarification - GPIO controlled
 regulator, USB VBUS,
Date: Wed, 4 Oct 2017 13:54:49 +0200
Message-ID: <abe393e3-66fe-3c00-8b87-2375cc01d6f5@majess.pl>
References: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
 <20171004103213.4ezs6ie6z6dq7pvh@sirena.co.uk>
 <e0352de3-f346-f6c0-5fab-7353d4c0d696@majess.pl>
 <20171004112704.beqzaxwsb5tg4nbm@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171004112704.beqzaxwsb5tg4nbm@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

Hi Mark,

> On Wed, Oct 04, 2017 at 12:45:39PM +0200, Łukasz Majewski wrote:
>>> On Tue, Oct 03, 2017 at 06:58:00PM +0200, Łukasz Majewski wrote:
> 
>>>   Perhaps this is something
>>> that could be implemented generically for USB as it's a hotpluggable bus
> 
>> In this case we use VBUS as a power supply voltage. The problem with
>> regulator API used in this case is that we enable it on boot-up, but then we
>> cannot "symulate hotplug" anymore.
> 
> I don't really understand what you mean there, sorry. 

I do use "regulator-fixed" to control VBUS.

The USB driver used regulator_enable/disable to supply power of VBUS.


What I do want to achieve:

For testing purpose I would like to enable/disable this supply (VBUS) 
and force/restart of re-enumeration.

> The majority of
> regulator usage is to supply power, use as reference voltages or
> similar.
> 


-- 
Best regards.

Łukasz Majewski
