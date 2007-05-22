From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [patch 2.6.22-rc2] ads7846 doc: handles tsc2046 too
Date: Tue, 22 May 2007 12:22:05 -0700
Message-ID: <1179861726.6122.50.camel@vence.hilman.org>
References: <200705221139.08689.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200705221139.08689.david-b@pacbell.net>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: David Brownell <david-b@pacbell.net>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Tue, 2007-05-22 at 11:39 -0700, David Brownell wrote:
> The TSC2046 is an updated version of the ADS7846 ... mention that in
> the Kconfig helptext and driver source.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Verified that ads7846 driver indeed works for tsc2046 on OMAP2430SDP
platform.

Acked-by: Kevin Hilman <khilman@mvista.com>
