From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [RFC/RFT 1/5] Input: implement proper locking in input core
Date: Tue, 24 Jul 2007 01:52:45 -0400
Message-ID: <200707240152.47006.dtor@insightbb.com>
References: <20070724044520.913891976.dtor@insightbb.com> <20070724044858.192608314.dtor@insightbb.com> <46A58FBA.5010505@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <46A58FBA.5010505@garzik.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Jeff, 

On Tuesday 24 July 2007 01:35, Jeff Garzik wrote:
> 
> spin_lock_irq() should generally be avoided.
> 
> In cases like the first case -- input_repeat_key() -- you are making 
> incorrect assumptions about the state of interrupts.  The other cases 
> are probably ok, but in general spin_lock_irq() has a long history of 
> being very fragile and quite often wrong.
> 
> Use spin_lock_irqsave() to be safe.  Definitely in input_repeat_key(), 
> but I strongly recommend removing spin_lock_irq() from all your patches 
> here.
>

Thasnk you for looking at the patches. Actually I went back and forth
between spin_lock_irq and spin_lock_irqsave.. I will change back to
irqsave version, it is indeed safer.

-- 
Dmitry
