From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [patch] hid: fix autocentering of PID devices
Date: Thu, 21 Jun 2007 00:53:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0706210046400.3068@twin.jikos.cz>
References: <466FDC51.5030703@gmail.com> <Pine.LNX.4.64.0706131746020.23280@twin.jikos.cz>
 <46705CBD.5040302@gmail.com> <Pine.LNX.4.64.0706132340560.23280@twin.jikos.cz>
 <4670673A.3050702@gmail.com> <Pine.LNX.4.64.0706181742480.12361@twin.jikos.cz>
 <467965CD.20507@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <467965CD.20507@gmail.com>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Dmitry Torokhov <dtor@insightbb.com>, linux-input@atrey.karlin.mff.cuni.cz, Diogo Kastrup <dk@bighost.com.br>
List-Id: linux-input@vger.kernel.org

On Wed, 20 Jun 2007, Anssi Hannula wrote:

> > did you make any progress here please? I am going to merge the patch, 
> > still I'd be understand what caused it (on the other hand from Diogo's 
> > last comment it doesn't seem 100% certain that we cased it somewhere 
> > around 2.6.20).
> I finally had time to bisect 2.6.20 vs 2.6.21, and for me it seems to 
> start happening after commit 4237081e573b99a48991aa71364b0682c444651c:

Hi Anssi,

thanks a lot. Could you please check any kernel after the commit 
46386b587086c8d2698222a031bf749688464032 (for example 2.6.22-rc1)? That 
should be the definitive fix for all issues with zeroing of unused bits in 
output reports.

Thanks,

-- 
Jiri Kosina
