From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [HP Jornada 6XX] - Onboard Keyboard support
Date: Sun, 22 Jul 2007 01:45:10 -0400
Message-ID: <200707220145.10563.dtor@insightbb.com>
References: <20070721181549.9d118414.Kristoffer.Ericson@Gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070721181549.9d118414.Kristoffer.Ericson@Gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

On Saturday 21 July 2007 21:15, Kristoffer Ericson wrote:
> Greetings,
> 
> Here we go again with another keyboard patch (this time for hp6xx).
> It consists of three files, where one contains the generic scan_keyb
> routines with needed header and the third is the specific hp6xx driver.

Please do not use scan_keyb. It goes around input core and directly into
legacy keyboard driver. For drivers that periodically poll/scan their
device input_polldev might be of interest.

-- 
Dmitry
