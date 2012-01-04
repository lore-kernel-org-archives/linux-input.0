From: Christopher Heiny <cheiny@synaptics.com>
Subject: Re: [RFC PATCH 00/11] input: Synaptics RMI4 Touchscreen Driver
Date: Tue, 3 Jan 2012 17:51:01 -0800
Message-ID: <4F03B085.6000101@synaptics.com>
References: <1324519802-23894-1-git-send-email-cheiny@synaptics.com> <CACRpkdbcK9SGtQf9g55h_PGPenrvc9kxPYfZXNV1-4K8NvdAgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbcK9SGtQf9g55h_PGPenrvc9kxPYfZXNV1-4K8NvdAgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jean Delvare <khali@linux-fr.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
List-Id: linux-input@vger.kernel.org

On 01/01/2012 05:51 AM, Linus Walleij wrote:
> On Thu, Dec 22, 2011 at 3:09 AM, Christopher Heiny<cheiny@synaptics.com>  wrote:
>
>> This patch implements a driver supporting Synaptics ClearPad and other
>> touchscreen sensors that use the RMI4 protocol, as defined here:
>
> This looks like a fundamental rewrite an huge improvement over the
> previous RMI4 patches, good job!
>
> I am not very deeply versed in the input subsystem but overall it looks
> good to me, nice structure etc. I hope to be able to get back to a detailed
> review and per-patch Acked-by:s ASAP.

Thanks!

We realized we were in a red queen's race by trying to both implement 
customer requests and restructure the system at the same time, so 
contracted Unixphere to help with the restructure.  We think the result 
was pretty good, and it's nice to hear compliments.

We'll look forward to your input after the detailed review.

					Thanks again,
						Chris
