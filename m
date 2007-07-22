From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [patch 1/3] m68k/mac: Make mac_hid_mouse_emulate_buttons() declaration visible
Date: Sun, 22 Jul 2007 00:22:40 -0400
Message-ID: <200707220022.41797.dtor@insightbb.com>
References: <20070720164043.523003359@mail.of.borg> <d120d5000707201151q433f1f3eteb479109291a54bd@mail.gmail.com> <Pine.LNX.4.64.0707211026070.18493@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <Pine.LNX.4.64.0707211026070.18493@anakin>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: linux-input@vger.kernel.org

Hi Geert,

On Saturday 21 July 2007 04:27, Geert Uytterhoeven wrote:
> On Fri, 20 Jul 2007, Dmitry Torokhov wrote:
> > 
> > I am OK with adding a new header file. I was just saying that placing
> > that declaration in linux/hid.h makes about the same sense as putting
> > it into linux/scsi.h
> 
> At first I just wanted to move it. Then I thought about the angry
> comments I would get about not moving it to a header file ;-)
> 
> <linux/hid.h> looked like the best candidate. <linux/kbd_kern.h> is
> another option.
> 

linux/kbd_kern.h sounds much better.

-- 
Dmitry
