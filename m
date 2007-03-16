From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [INPUT] HIL: fix rwlock recursion bug in hp_sdc_mlc driver
Date: Fri, 16 Mar 2007 01:00:44 -0400
Message-ID: <200703160100.45535.dtor@insightbb.com>
References: <200703152131.26568.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200703152131.26568.deller@gmx.de>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Helge Deller <deller@gmx.de>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Thursday 15 March 2007 16:31, Helge Deller wrote:
> Hi Dmitry,
> 
> the following patch fixes a rwlock recursion bug which happens when insmoding hp_sdc_mlc.ko:
> 
>     HP SDC MLC: Registering the System Domain Controller's HIL MLC.
>     BUG: rwlock recursion on CPU#0, hotplug/1814, 00854734

Applied, thank you Helge.

-- 
Dmitry
