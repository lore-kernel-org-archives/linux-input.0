From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input: i8042 - disable active multiplexing by default
Date: Sat, 11 Oct 2014 11:12:03 +0200
Message-ID: <5438F463.50003@redhat.com>
References: <20141010205131.GA3271@dtor-ws> <20141010211827.GA26222@redhat.com> <20141010212245.GB38320@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42457 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbaJKJMO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Oct 2014 05:12:14 -0400
In-Reply-To: <20141010212245.GB38320@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dave Jones <davej@redhat.com>, linux-input@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Vojtech Pavlik <vojtech@suse.cz>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org

Hi,

On 10/10/2014 11:22 PM, Dmitry Torokhov wrote:
> On Fri, Oct 10, 2014 at 05:18:27PM -0400, Dave Jones wrote:
>> On Fri, Oct 10, 2014 at 01:51:31PM -0700, Dmitry Torokhov wrote:
>>
>>  >  /*
>>  > - * Some Fujitsu notebooks are having trouble with touchpads if
>>  > - * active multiplexing mode is activated. Luckily they don't have
>>  > - * external PS/2 ports so we can safely disable it.
>>  > - * ... apparently some Toshibas don't like MUX mode either and
>>  > - * die horrible death on reboot.
>>  > + * Some laptops do increment active multiplexing mode correctly;
>>  > + * unfortunately they are in minority.
>>  >   */
>>
>> s/increment/implement/ ?
> 
> Thanks Dave, I'll fix it up.

The patch looks good to me, and with the above fixup is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans
