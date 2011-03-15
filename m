From: Bastien Nocera <hadess@hadess.net>
Subject: Re: Keycode for "main hardware button" on slate?
Date: Tue, 15 Mar 2011 18:12:11 +0000
Message-ID: <1300212732.2088.17.camel@novo.hadess.net>
References: <1299520075.18332.146.camel@novo.hadess.net>
	 <20110311082934.e0ecce45.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:40845 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758100Ab1COSMQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Mar 2011 14:12:16 -0400
In-Reply-To: <20110311082934.e0ecce45.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org

On Fri, 2011-03-11 at 08:29 +0100, Antonio Ospite wrote:
> On Mon, 07 Mar 2011 17:47:54 +0000
> Bastien Nocera <hadess@hadess.net> wrote:
> 
> > Heya,
> > 
> > I've installed Fedora 15 onto a WeTab slate, and it has 2 "hardware"
> > buttons. One is power (already used to come in and out of suspend), and
> > another one that I'd like to use to get the interface running on it to
> > go back to its "home" screen.
> >
> 
> Is there any emblem near the button on the case? IMHO the first choice
> would be to assign a code following the visual hint given by the
> manufacturer if any.
> 
> > Any ideas what KEY_* I should use for this functionality?
> >
> 
> If KEY_HOMEPAGE is meant specifically for the web browser maybe
> KEY_FRONT can represent the home screen of the main UI: it makes me
> think to "front desk", but I am not sure about what its intended use
> actually is.

KEY_FRONT could be the one, yes.

