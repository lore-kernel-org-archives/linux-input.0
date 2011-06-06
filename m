From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH 8/25] sony-laptop: sony_nc_notify rewritten and improved
Date: Mon, 6 Jun 2011 21:42:32 +0900
Message-ID: <20110606124231.GA30602@kamineko.org>
References: <4DE8FC4A.9010401@absence.it>
 <4DE8FFE0.5070506@absence.it>
 <20110604084338.GD7194@kamineko.org>
 <4DEA1664.4090409@absence.it>
 <20110605223815.GC26835@kamineko.org>
 <4DECC6C6.2050409@absence.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4DECC6C6.2050409@absence.it>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Marco Chiappero <marco@absence.it>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 06, 2011 at 02:23:34PM +0200, Marco Chiappero wrote:
> Il 06/06/2011 00:38, Mattia Dongili ha scritto:
> >it's a bit out of context but I guess it should work. It would be good
> >to have sony_nc_hotkeys_decode also report the "not decoded" case
> >consistently back to callers though.
> 
> Do you mean a negative value instead of 0? If so, let's return -EIO
> (or -2) on error and -1 for the unknown mapping case, else the
> translated key value (> 0).

I was more thinking of -EINVAL for all cases.

-- 
mattia
:wq!
