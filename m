From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] hid: hidraw_connect memleak fix
Date: Thu, 27 Sep 2007 11:40:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709271139380.7567@jikos.suse.cz>
References: <200709270933.13497.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <200709270933.13497.m.kozlowski@tuxland.pl>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 27 Sep 2007, Mariusz Kozlowski wrote:

> It looks like hidraw_connect() is leaking memory in case of failure. 
> Also it should return -ENOMEM when kzalloc fails.

Mariusz,

good catch, will apply to me tree.

Thanks,

-- 
Jiri Kosina
SUSE Labs
