From: Qi Yong <qiyong@mail.fc-cn.com>
Subject: Re: [patch] add printk_ratelimit to atkbd_interrupt
Date: Wed, 20 Jun 2007 15:34:26 +0800
Message-ID: <4678D882.3090606@mail.fc-cn.com>
References: <20070620011753.GA16692@virgo.fc-cn.com> <200706200013.13029.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200706200013.13029.dtor@insightbb.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, michal.k.k.piotrowski@gmail.com
List-Id: linux-input@vger.kernel.org

Dmitry Torokhov wrote:
> On Tuesday 19 June 2007 21:17, Qi Yong wrote:
>   
>> Add printk_ratelimit() to atkbd_interrupt(). I get "Spurious ACK" messages flushing on my
>> screen. This patch helps to read the screen.
>>
>>     
>
> Will apply, thank you.
>
> Do you have any idea why you are getting spurios ACK messages? Do you have
> an application fiddling with keyboard port or do you have blink driver
> enabled?

No idea. It is at boot time.
Yes, i have CONFIG_BLINK=y.

(add CC: Michal Piotrowski)

-- 
Qi Yong
