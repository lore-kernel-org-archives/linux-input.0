From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [2.6 patch] make the dummy touchkit_ps2_detect() static
Date: Thu, 30 Aug 2007 01:11:39 -0400
Message-ID: <200708300111.39956.dtor@insightbb.com>
References: <20070814212252.GF18945@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070814212252.GF18945@stusta.de>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Adrian,

On Tuesday 14 August 2007 17:22, Adrian Bunk wrote:
> The dummy touchkit_ps2_detect() for the CONFIG_MOUSE_PS2_TOUCHKIT=n case 
> shouldn't be a global function.
> 

Applied, thank you.

Btw, sorry for the long silence - I had a hard drive crash and the day
after I restored everything the disk controller decided to die as well
and write garbage all over the new disk ;(

-- 
Dmitry
