From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [Bugme-new] [Bug 10327] New: keyboard stops responding after
 "ifdown eth0"
Date: Wed, 26 Mar 2008 01:01:28 +0100
Message-ID: <47E99258.3060005@s5r6.in-berlin.de>
References: <bug-10327-10286@http.bugzilla.kernel.org/> <20080325143941.300d415f.akpm@linux-foundation.org> <47E9721C.2000306@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <47E9721C.2000306@better.se>
Sender: netdev-owner@vger.kernel.org
To: Marcus Better <marcus@better.se>
Cc: Andrew Morton <akpm@linux-foundation.org>, bugme-daemon@bugzilla.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

One possible reason for unresponsive keyboard is a workqueue job in the 
shared workqueue sleeping very long or indefinitely.

Sky2.c has only one workqueue job: sky2_restart().
-- 
Stefan Richter
-=====-==--- --== ==-=-
http://arcgraph.de/sr/
