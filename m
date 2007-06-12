From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH] input: make 2 macros in gameport.c TSC-aware
Date: Tue, 12 Jun 2007 01:24:35 -0400
Message-ID: <200706120124.36623.dtor@insightbb.com>
References: <alpine.BSF.0.99.0706110624150.5014@micmac.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <alpine.BSF.0.99.0706110624150.5014@micmac.localdomain>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-joystick@atrey.karlin.mff.cuni.cz
Cc: Miltiadis Margaronis <mmargaron@gmail.com>, linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

On Monday 11 June 2007 00:12, Miltiadis Margaronis wrote:
> 
>   This makes DELTA and GET_TIME in drivers/input/gameport/gameport.c
>   similar to the ones in drivers/input/joystick/analog.c . Worked on
>   2.6.22-rc4-git2.
> 

I was told with the introduction of tickless kernels and such the best
option is to convert gameport to use hires timers.

-- 
Dmitry
