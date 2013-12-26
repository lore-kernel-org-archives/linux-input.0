From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2] Add ff-memless-next module
Date: Thu, 26 Dec 2013 23:40:03 +0100
Message-ID: <20131226234003.22bd8e91c64784d9b66c25e3@studenti.unina.it>
References: <5668718.jm7F3C2ifr@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:60542 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753909Ab3LZWkY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Dec 2013 17:40:24 -0500
In-Reply-To: <5668718.jm7F3C2ifr@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, joe@perches.com, elias.vds@gmail.com

On Thu, 26 Dec 2013 19:18:31 +0100
Michal Mal=FD <madcatxster@prifuk.cz> wrote:

> This patch adds "ff-memless-next" module.
>=20
> Changelog:
> v2 - Remove unnecessary "else" branches
>

Michal, these annotations should go after the three dash line (---), an=
d
the commit message must go here, before the three dashes.

> Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>
> Signed-off-by: Michal Mal=FD <madcatxster@prifuk.cz>
> ---
  ^^^
So put from here on the stuff you want to tell humans but you don't wan=
t
to show up in the git history.

git-am will ignore the text between the "---" and the actual "diff"
blocks, so this is the best place to put annotations and patch
commentary.

See git-format-patch and git-am man pages for the details.

Ciao,
   Antonio

--=20
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
