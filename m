From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [PATCH] input - Add Euro and Dollar keys
Date: Tue, 13 Nov 2007 13:53:45 +0000
Message-ID: <200711131353.45677.carlos@strangeworlds.co.uk>
References: <200710251356.21758.cathectic@slackadelic.com> <200710260041.26041.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200710260041.26041.dmitry.torokhov@gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dmitry,

On Friday 26 October 2007 05:41:25 Dmitry Torokhov wrote:
> > Most newer Acer laptops (from 2005 onwards) now ship with an extra Dollar
> > and Euro key either side of the 'Up' arrow. These cannot be mapped in the
> > traditional way, since they are not combination keys.
>
> Applied, thank you Carlos. I tought about KEY_CURRENCY some more and I
> don't think it would work well in this case.

Unfortunately, my patch has a small problem, in that setkeycodes won't accept 
the values for my laptop keyboard (since they are obviously > 256).

Is there another way around this (besides submitting another patch to move the 
keys to lower keycodes - e.g. something in the 246-255 range)?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
