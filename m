From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH v2 1/1] Input: mouse: cyapa - Add support for cyapa smbus
 protocol
Date: Thu, 14 Feb 2013 18:19:27 +0100
Message-ID: <20130214171927.GA538@polaris.bitmath.org>
References: <1359673513-22328-1-git-send-email-bleung@chromium.org>
 <1360527340-25936-1-git-send-email-bleung@chromium.org>
 <20130214042635.GC2472@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130214042635.GC2472@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, khali@linux-fr.org, olofj@chromium.org, djkurtz@chromium.org, dudl@cypress.com
List-Id: linux-input@vger.kernel.org

On Wed, Feb 13, 2013 at 08:26:35PM -0800, Dmitry Torokhov wrote:
> On Sun, Feb 10, 2013 at 12:15:40PM -0800, Benson Leung wrote:
> > This patch adds support for the Cypress APA Smbus Trackpad type,
> > which uses a modified register map that fits within the
> > limitations of the smbus protocol.
> > 
> > Devices that use this protocol include:
> > CYTRA-116001-00 - Samsung Series 5 550 Chromebook trackpad
> > CYTRA-103002-00 - Acer C7 Chromebook trackpad
> > CYTRA-101003-00 - HP Pavilion 14 Chromebook trackpad
> > 
> > Signed-off-by: Dudley Du <dudl@cypress.com>
> > Signed-off-by: Benson Leung <bleung@chromium.org>
> > Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> > ---
> > v2 : Minor style cleanup. Removed unused struct device *dev declarations.
> > ---
> 
> Applied, thank you Benson.
> 
> Henrik, I put you down as "reviewed-by".

Perfect, thank you.

Henrik
