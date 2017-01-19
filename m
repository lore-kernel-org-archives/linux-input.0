From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 00/33] Input: Automated coccinelle cleanup
Date: Wed, 18 Jan 2017 21:06:55 -0800
Message-ID: <1484802415.18392.2.camel@perches.com>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
         <1484790156.9538.18.camel@perches.com>
         <2226a8e4-6d44-a50e-c3ca-03311e79c6a7@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2226a8e4-6d44-a50e-c3ca-03311e79c6a7@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, 2017-01-18 at 21:04 -0800, Guenter Roeck wrote:
> On 01/18/2017 05:42 PM, Joe Perches wrote:
> > On Wed, 2017-01-18 at 09:46 -0800, Guenter Roeck wrote:
> > > The conversion was done automatically with coccinelle using several semantic
> > > patches. The semantic patches and the scripts used to generate this commit
> > > log are available at https://github.com/groeck/coccinelle-patches.
> > 
> > It'd be better to include the script in this 0/n patch
> > so that if github entry changes, the 0/n patch is useful.
> > 
> For this set it would have been possible, though even the rules used here add
> up to more than 1,000 lines.

How many errors do you think are in the script?
1000+ lines, likely there 10+ errors/defects.
