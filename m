From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.22-rc2] ads7846 doc: handles tsc2046 too
Date: Tue, 22 May 2007 16:09:42 -0400
Message-ID: <d120d5000705221309q43e2f51vd023212712c0f1f5@mail.gmail.com>
References: <200705221139.08689.david-b@pacbell.net>
	 <1179861726.6122.50.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1179861726.6122.50.camel@vence.hilman.org>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kevin Hilman <khilman@mvista.com>
Cc: David Brownell <david-b@pacbell.net>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi,

On 5/22/07, Kevin Hilman <khilman@mvista.com> wrote:
> On Tue, 2007-05-22 at 11:39 -0700, David Brownell wrote:
> > The TSC2046 is an updated version of the ADS7846 ... mention that in
> > the Kconfig helptext and driver source.
> >
> > Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
>
> Verified that ads7846 driver indeed works for tsc2046 on OMAP2430SDP
> platform.
>
> Acked-by: Kevin Hilman <khilman@mvista.com>
>

Thanks, I will get this in. Since there are no code changes there is
no point for waiting for 2.6.23 merge window to open.

-- 
Dmitry
