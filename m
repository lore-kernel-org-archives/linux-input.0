From: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Input: i8042 - disable active multiplexing by default
Date: Fri, 10 Oct 2014 17:18:27 -0400
Message-ID: <20141010211827.GA26222@redhat.com>
References: <20141010205131.GA3271@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:6208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbaJJVSn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Oct 2014 17:18:43 -0400
Content-Disposition: inline
In-Reply-To: <20141010205131.GA3271@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Vojtech Pavlik <vojtech@suse.cz>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org

On Fri, Oct 10, 2014 at 01:51:31PM -0700, Dmitry Torokhov wrote:

 >  /*
 > - * Some Fujitsu notebooks are having trouble with touchpads if
 > - * active multiplexing mode is activated. Luckily they don't have
 > - * external PS/2 ports so we can safely disable it.
 > - * ... apparently some Toshibas don't like MUX mode either and
 > - * die horrible death on reboot.
 > + * Some laptops do increment active multiplexing mode correctly;
 > + * unfortunately they are in minority.
 >   */

s/increment/implement/ ?

	Dave

