From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 09/11] Input: alps - remove unlikely() from IS_ERR*()
 condition
Date: Sat, 31 Aug 2019 13:32:02 -0700
Message-ID: <762056d9c081c40f3fc760c9af79d6851f0a65e5.camel@perches.com>
References: <20190829165025.15750-1-efremov@linux.com>
         <20190829165025.15750-9-efremov@linux.com>
         <20190829175039.GA187474@dtor-ws> <20190831152500.eg7xqo5ace6wu427@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190831152500.eg7xqo5ace6wu427@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Denis Efremov <efremov@linux.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sat, 2019-08-31 at 17:25 +0200, Pali Rohár wrote:
> On Thursday 29 August 2019 10:50:39 Dmitry Torokhov wrote:
> > On Thu, Aug 29, 2019 at 07:50:23PM +0300, Denis Efremov wrote:
> > > "unlikely(IS_ERR_OR_NULL(x))" is excessive. IS_ERR_OR_NULL() already uses
> > > unlikely() internally.
> > 
> > The keyword here is _internally_.
> > 
> > https://lore.kernel.org/lkml/20190821174857.GD76194@dtor-ws/
> > 
> > So please no.

I think it poor form not to simply restate your original
objection from 4 message levels below this link

https://lists.gt.net/linux/kernel/2269724

   Hm... I do not like this change. If I read code 
    
    if (unlikely(IS_ERR_OR_NULL(priv->dev3))) 
    
   then I know that it is really unlikely that condition will be truth and 
   so this is some case of error/exception or something that normally does 
   not happen too much. 
    
   But if I read code 
    
    if (IS_ERR_OR_NULL(priv->dev3)) 
    
   I know nothing about chance that this condition will be truth. Explicit 
   unlikely in previous example give me more information. 
    
I alslo think this argument is dubious as it also applies
to any IS_ERR and all the unlikely uses have been removed
from those.
